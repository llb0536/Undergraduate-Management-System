# -*- encoding : utf-8 -*-
require 'spreadsheet'

class Float
  def strip
    return self
  end
end

class CoreController < ApplicationController
  before_filter :authenticate_user!
  def system_jobs_index
  end
  def system_jobs_update_credit
    Stalker.enqueue("update_credit",:threshold=>15.0)
    render text:'enqueued'
  end
  def system_jobs_update_klass2s
    Stalker.enqueue("update_klass2s")
    render text:'enqueued'
  end
  

  def import
    @msg = ''
    if params[:log_id]
      importLog = ImportLog.find(params[:log_id])
    else
      importLog = ImportLog.create!(co_count:0,co_no_count:0,user_id:current_user.id,course_created_count:0,stu_created_count:0,erroneous:true)
    end
    begin
      if params[:from]=='server'
        worksheets = Spreadsheet.open(params[:filepath]).worksheets
        @msg += params[:filepath].split('/')[-1]+"<br><br>"
        raise RuntimeError,'请保证xls文件只含一个工作表' if worksheets.count != 1
        worksheet = worksheets.first
        raise RuntimeError,'数据表必须为15列，其中第1列为空列；第1行的第2列为标题' unless worksheet.row(0).size==15
        title = worksheet.row(0)[1]
        raise RuntimeError,'标题不可以为空' unless title and title!=''
        raise RuntimeError,'标题必须以sx开始' unless title[0..1]=='sx'
        raise RuntimeError,'标题必须匹配正则表达式^\D+(\d+)(.*)班' unless title =~ /^\D+(\d+)(.*)班/
        grade_name = $1
        klass_name = $2
        klass_name = klass_name[1..-1] if klass_name[0]=='B'
        grade = Grade.find_by_name(grade_name)
        if !grade
          grade = Grade.create!(name:grade_name)
          @msg+="创建年级#{grade.name}<br><br>"
        end
        klass = grade.klasses.find_by_name(klass_name)
        if !klass
          klass = grade.klasses.create!(name:klass_name)
          @msg+="创建班级#{klass.name}(属于年级:#{grade.name})<br><br>"
        end
        importLog.grade_created = grade.name
        importLog.klass_created = klass.name
        course_id = Array.new
        #Step 1: Create all the courses{
          row_one = worksheet.row(1) #numbers
          row_two = worksheet.row(2) #names
          row_three = worksheet.row(3) #credits
          size = row_one.size
          raise RuntimeError,'列数不同？' if size != row_two.size or size != row_three.size
          while row_one[size-1]==nil
            size -= 1
          end
          5.upto(size-1) do |i|
            course = Course.find_by_number(row_one[i].strip)
            if !course
              course = Course.create!(number:row_one[i].strip,name:row_two[i].strip,credit:row_three[i].strip)
              importLog.course_created_count += 1
            end
            course_id[i] = course.id
          end
        #}
        #Step 2: Students {
        j=5
        j = params[:j].to_i if params[:j]
        j_lim = j
        while j<=j_lim
          row = worksheet.row(j)
          break if row.empty? or !row[1] or !row[4]
          number = row[1].strip!
          name = row[4].strip!
          student = Student.find_by_number(number)
          if !student
            student = klass.students.create!(number:number,name:name)
            importLog.stu_created_count += 1
          else
            student.update_attributes!(klass_id:klass.id)
          end
          FamilyName.letExist!(student.name[0])
          5.upto(size-1) do |i|
            row[i].strip!
            next if row[i]=="-"
            if row[i]=="优秀"
              row[i]="90" 
            elsif row[i]=="良好"
              row[i]="80"
            elsif row[i]=="中等"
              row[i]="70" 
            elsif row[i]=="不及格"
              row[i]="59"
            end
            co = Assignment.where(course_id:course_id[i],student_id:student.id).first
            if co
              importLog.co_no_count+=1
              co.update_attributes!(score:row[i])
            else
              co = Assignment.create!(course_id:course_id[i],student_id:student.id,score:row[i])
              importLog.co_count +=1
            end
            @msg += "<span style=\"color:red\">" if co.score<60
            @msg += "[ #{name}, #{co.course.name}, #{co.score} ]"
            @msg += "</span>" if co.score<60
            @msg += "<br>"
          end
          j+=1
        end
        #}
        @msg += "<br>新课程记录创建：#{importLog.course_created_count}条" if importLog.course_created_count>0
        @msg += "<br><br>已创建#{importLog.stu_created_count}条新学生记录" if importLog.stu_created_count>0
        @msg += "<br><br>已导入 #{importLog.co_count} 条新的学生成绩记录<br><br> （#{importLog.co_no_count}条成绩覆写记录）"
        @cont = nil
        if j>j_lim
          @msg = "<span style=\"color:red\">正在导入更多数据，请勿离开此页</span><br><br>" + @msg
          @cont_path = '/core/import'
          @cont = Hash.new
          @cont[:from] = params[:from]
          @cont[:filepath] = params[:filepath]
          @cont[:j] = j
          @cont[:log_id] = importLog.id
        else
          @msg = "<span style=\"color:green\">全部完成</span><br><br>" + @msg
          importLog.erroneous = false
        end
      elsif params[:from]=='local'
        path = "#{RAILS_ROOT}/data/score/upload/#{Time.now.strftime('%Y%m%d%H%M%S')}"
        File.open(path,"wb") do |f|
          f.write(params[:datafile].read)
        end
        @msg += "<br>文件上传已经完成，正在开始导入"
        @cont_path = '/core/import'
        @cont = Hash.new
        @cont[:from] = 'server'
        @cont[:filepath] = path
        @cont[:j] = 5
        @cont[:log_id] = importLog.id
      else
        raise RuntimeError,'from参数未指定'
      end
    rescue Exception => e
      @msg += "错误：#{e}<br><br>"
      @msg += e.backtrace.first
    end
    importLog.save!
    render :template=>'core/showmsg'
  end

  def import2
    @msg = ''
    if params[:log_id]
      import2Log = Import2Log.find(params[:log_id])
    else
      import2Log = Import2Log.create!(students_updated:0,students_created:0,user_id:current_user.id,erroneous:true)
    end
    begin    
      if params[:from]=='server'
        student_created = student_updated = nil
        worksheets = Spreadsheet.open(params[:filepath]).worksheets
        @msg += params[:filepath].split('/')[-1]+"<br><br>"
        raise RuntimeError,'请保证xls文件只含一个工作表' if worksheets.count != 1
        worksheet = worksheets.first
        firstrow = worksheet.row(0)
        firstrow.each {|column| column.strip!}
        number_first = firstrow.index('xh')
        name_first = firstrow.index('xm')
        bj_first = firstrow.index('bj')
        xb_first = firstrow.index('xb')
        while i=firstrow.index('线')
          firstrow[i]='fenshuxian'
        end
        raise RuntimeError,'不能没有xm或xh列' if !number_first or !name_first
        j = 1
        j = params[:j].to_i if params[:j]
        j_lim = j+11
        while j<=j_lim
          row = worksheet.row(j)
          break if row.empty? or !row[number_first] or !row[name_first]
          if row[number_first].class == Float
            row[number_first] = row[number_first].to_i
          end
          number = row[number_first].to_s.strip
          name = row[name_first].to_s.strip
          student = Student.find_by_number(number)
          if student
            import2Log.students_updated += 1
            student_updated = student
          else
            import2Log.students_created += 1
            student = Student.create!(number:number,name:name)
            student_created = student
          end
          unless !bj_first
            raise RuntimeError,'有的学生缺少班级记录' unless row[bj_first]
            student.bj = row[bj_first].strip
            raise RuntimeError,'bj列必须匹配正则表达式^\D+(\d+)(.*)$' unless student.bj =~ /^\D+(\d+)(.*)$/
            grade_name = $1
            klass_name = $2
            klass_name = klass_name[1..-1] if klass_name[0]=='B'
            grade = Grade.find_by_name(grade_name)
            grade ||= Grade.create!(name:grade_name)
            klass = Klass.find_by_name(klass_name)
            klass ||= Klass.create!(name:klass_name,grade_id:grade.id)
            student.klass_id = klass.id
          end
          unless !xb_first
            if row[xb_first]=='男'
              student.is_male = true
            else
              student.is_male = false
            end
          end
          0.upto(firstrow.count-1) do |i|
            next if 'xh'==firstrow[i] or 'xm'==firstrow[i] or 'xb'==firstrow[i]
            eval("student.#{firstrow[i]} = row[#{i}].strip if row[#{i}]")
          end
          @msg += "[ #{row[number_first]}, #{row[name_first]}, #{student.bj}]<br>"
          FamilyName.letExist!(student.name[0])
          student.save!
          j+=1
        end

        @msg += "<br>已创建#{import2Log.students_created}条新学生记录" if import2Log.students_created>0
        @msg += "<br><br>已更新#{import2Log.students_updated}位学生的记录" if import2Log.students_updated>0
        @cont = nil
        if j>j_lim
          @msg = "<span style=\"color:red\">正在导入更多数据，请勿离开此页</span><br><br>" + @msg
          @cont_path = '/core/import2'
          @cont = Hash.new
          @cont[:from] = params[:from]
          @cont[:filepath] = params[:filepath]
          @cont[:j] = j
          @cont[:log_id] = import2Log.id
        else
          @msg = "<span style=\"color:green\">全部完成</span><br><br>" + @msg
          import2Log.erroneous = false
        end
      elsif params[:from]=='local'
        path = "#{RAILS_ROOT}/data/info/upload/#{Time.now.strftime('%Y%m%d%H%M%S')}"
        File.open(path,"wb") do |f|
          f.write(params[:datafile].read)
        end
        @msg += "<br>文件上传已经完成，正在开始导入"
        @cont_path = '/core/import2'
        @cont = Hash.new
        @cont[:from] = 'server'
        @cont[:filepath] = path
        @cont[:j] = 1
        @cont[:log_id] = import2Log.id
      else
        raise RuntimeError,'from参数未指定'
      end
    rescue Exception => e
      @msg += "错误：#{e}<br><br>"
      p e.backtrace
    end
    import2Log.save!
    render :template=>'core/showmsg'
  end
  
  
  
  def import3
    @msg = ''
    if params[:log_id]
      import3Log = Import3Log.find(params[:log_id])
    else
      import3Log = Import3Log.create!(students_updated:0,students_created:0,user_id:current_user.id,erroneous:true)
    end
    begin    
      if params[:from]=='server'
        student_created = student_updated = nil
        worksheets = Spreadsheet.open(params[:filepath]).worksheets
        @msg += params[:filepath].split('/')[-1]+"<br><br>"
        raise RuntimeError,'请保证xls文件只含一个工作表' if worksheets.count != 1
        worksheet = worksheets.first
      p  firstrow = worksheet.row(0)
	    p huojiangdengji_first = firstrow.index('获奖等级')
      p huojiangdengji_first ||= firstrow.index('奖项')
      p jin_e_first = firstrow.index('金额')
      p number_first = firstrow.index('学号')
      p name_first = firstrow.index('姓名')

      
      if !huojiangdengji_first or !number_first
        p firstrow = worksheet.row(1)
        p huojiangdengji_first = firstrow.index('获奖等级')
        p huojiangdengji_first ||= firstrow.index('奖项')
        p jin_e_first = firstrow.index('金额')
        p number_first = firstrow.index('学号')
        p name_first = firstrow.index('姓名')
      end
      raise RuntimeError,'不能没有获奖等级 金额 学号 姓名' if !huojiangdengji_first or !number_first

      yuanxi_first = worksheet.row(0).index('院系')
      yuanxi_first ||= worksheet.row(1).index('院系')



        event = String.new(File.basename(params[:filepath]))
        
        j = 1
        j = params[:j].to_i if params[:j]
        j_lim = j+1000
        @msg += "正在处理行#{j}至行#{j_lim}"
        while j<=j_lim
          row = worksheet.row(j)
          break if !row or row.empty? or !row[number_first] or !row[name_first] 
          j+=1 and next if yuanxi_first and !(row[yuanxi_first] =~ /数学/)
          if row[number_first].class == Float
            row[number_first] = row[number_first].to_i
          end
          number = row[number_first].to_s.strip
          name = row[name_first].to_s.strip
          student = Student.find_by_number(number)
          if !student
            student = Student.new
            student.number = number.to_s
            student.name = name.to_s
            student.save!
            @msg += "创建学生 #{student.name}<br>"
            import3Log.students_created+=1
          end
          @msg += "学生 #{number} - #{student.name}"
          if !student.scholarships.find_by_event(event)
            if jin_e_first
              jin_e = row[jin_e_first].to_i
            else
              jin_e = 0
            end
            student.scholarships.create!(level:row[huojiangdengji_first],acount:jin_e,event:event)
            @msg += " - #{jin_e}元 - #{event}"
          end
          @msg += "<br>"
          import3Log.students_updated += 1
          student.save!
          j+=1
        end
        @msg += "<br>已创建#{import3Log.students_created}条新学生记录" if import3Log.students_created>0
        @msg += "<br><br>已更新#{import3Log.students_updated}条记录" if import3Log.students_updated>0
        @cont = nil
        if j>j_lim
          @msg = "<span style=\"color:red\">正在导入更多数据，请勿离开此页</span><br><br>" + @msg
          @cont_path = '/core/import3'
          @cont = Hash.new
          @cont[:from] = params[:from]
          @cont[:filepath] = params[:filepath]
          @cont[:j] = j
          @cont[:log_id] = import3Log.id
        else
          @msg = "<span style=\"color:green\">全部完成</span><br><br>" + @msg
          import3Log.erroneous = false
        end
      elsif params[:from]=='local'
        path = "#{RAILS_ROOT}/data/huojiang/upload/#{Time.now.strftime('%Y%m%d%H%M%S')}"
        File.open(path,"wb") do |f|
          f.write(params[:datafile].read)
        end
        @msg += "<br>文件上传已经完成，正在开始导入"
        @cont_path = '/core/import3'
        @cont = Hash.new
        @cont[:from] = 'server'
        @cont[:filepath] = path
        @cont[:j] = 1
        @cont[:log_id] = import3Log.id
      else
        raise RuntimeError,'from参数未指定'
      end
    rescue Exception => e
      @msg += "错误：#{e}<br><br>"
      p e.backtrace
    end
    import3Log.save!
    render :template=>'core/showmsg'
  end


  
  def import4
    @msg = ''
    if params[:log_id]
      import4Log = Import4Log.find(params[:log_id])
    else
      import4Log = Import4Log.create!(students_updated:0,students_created:0,user_id:current_user.id,erroneous:true)
    end
    begin    
      if params[:from]=='server'
        student_created = student_updated = nil
        worksheets = Spreadsheet.open(params[:filepath]).worksheets
        @msg += params[:filepath].split('/')[-1]+"<br><br>"
        ttt=''
worksheets.each do |worksheet|
  event = String.new(File.basename(params[:filepath]).split('.')[0..-2].join('.').strip)
  sem = Seminar.find_or_create_by_name(event)
  memo = ''
  j = 0
  j = params[:j].to_i if params[:j]
  while j<worksheet.count
    row = worksheet.row(j)
    row.each do |cell|
      next unless cell
      cell = cell.to_i if cell.class==Float
      cell = cell.to_s
      cell.strip!
      if cell=~/^(\d+)$/
        if stu = Student.find_by_number($1)
          unless stu.seminars.include?(sem)
            stu.seminars << sem
            stu.save!
          end
        end
      else
        memo+= " #{cell}"
      end
    end
    j+=1
  end
  sem.memo = memo.strip if !sem.memo
  sem.save!
end

        @msg += "<br>已创建#{import4Log.students_created}条新学生记录" if import4Log.students_created>0
        @msg += "<br><br>已更新#{import4Log.students_updated}条记录" if import4Log.students_updated>0
        @cont = nil

          @msg = "<span style=\"color:green\">全部完成</span><br><br>" + @msg
          import4Log.erroneous = false

      elsif params[:from]=='local'
        path = "#{RAILS_ROOT}/data/huojiang/upload/#{Time.now.strftime('%Y%m%d%H%M%S')}"
        File.open(path,"wb") do |f|
          f.write(params[:datafile].read)
        end
        @msg += "<br>文件上传已经完成，正在开始导入"
        @cont_path = '/core/import4'
        @cont = Hash.new
        @cont[:from] = 'server'
        @cont[:filepath] = path
        @cont[:j] = 1
        @cont[:log_id] = import4Log.id
      else
        raise RuntimeError,'from参数未指定'
      end
    rescue Exception => e
      @msg += "错误：#{e}<br><br>"
      p e.backtrace
    end
    import4Log.save!
    render :template=>'core/showmsg'
  end
end
