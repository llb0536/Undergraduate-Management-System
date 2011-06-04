# -*- encoding : utf-8 -*-
class StudentsController < ApplicationController
  before_filter :authenticate_user!
  # GET /students
  # GET /students.xml
  def index
    if params[:goto]
      student = Student.find_by_name(params[:goto])
      redirect_to student and return if student
      student = Student.find_by_number(params[:goto])
      redirect_to student and return if student
      redirect_to students_path and return
    end
    do_it(:order,'number')
    do_it(:per,50)
    
    @students = Student
    @students = Course.find(params[:course_id]).students if params[:course_id]
    @students = @students.where(klass_id:Grade.find(params[:grade_id]).klasses.collect(&:id)) if params[:grade_id]
    @students = @students.where(klass_id:params[:klass_id]) if params[:klass_id]
    @students = @students.where(paixuzi:params[:paixuzi]) if params[:paixuzi]
    @students = @students.where(surname:FamilyName.find(params[:surname_id]).hanzi) if params[:surname_id]
    @students = @students.where(number_prefix:params[:number_prefix]) if params[:number_prefix]
    @students = @students.where(klass2_id:params[:klass2_id]) if params[:klass2_id]
    @students = @students.order(params[:order])
    @students = @students.page(params[:page]).per(params[:per])
    @order = params[:order]
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @yixiu=@student.yixiu;
    @bujige=@student.bujige;
    @editing = Hash.new(false)
    @editing['personal_info'] = true if params[:edit]=='personal_info' or params[:edit]=='all'
    @editing['gk_info'] = true if params[:edit]=='gk_info' or params[:edit]=='all'
    @editing['chengji'] = true if params[:edit]=='chengji' or params[:edit]=='all'
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end
  
  def school_report
    render text:'开发中' and return
    @student = Student.find(params[:id])
    render :layout=>false
  end
  
  def talk_records
    @student = Student.find(params[:id])
    @talk_record = TalkRecord.new(student_id:@student.id)
    @talk_record.student_id = @student.id
    respond_to do |format|
      format.xls{
                Spreadsheet.client_encoding = 'UTF-8'
                book = Spreadsheet::Workbook.new
                data = StringIO.new('')
                sheet1 = book.create_worksheet :name => @student.name+'的谈话纪录'
                sheet1.row(0).replace %w{发生日期 谈话人 内容摘要 备注}
                sheet1.row(0).height = 20
                format = Spreadsheet::Format.new :weight => :bold,
                                                 :size => 10
                sheet1.row(0).default_format = format
                bold = Spreadsheet::Format.new :weight => :bold
                sheet1.column(0).width = 20
                sheet1.column(1).width = 10
                sheet1.column(2).width = 10
                sheet1.column(3).width = 30
                sheet1.column(4).width = 40

                
                i=1
            		@student.talk_records.each do |talk_record|
            		  sheet1.row(i).replace [talk_record.happened_at.strftime("%Y年%m月%d日"),
            		    talk_record.talker,
            		    talk_record.about,
            		    talk_record.memo]
            		  sheet1.row(i).set_format(0, bold)
            		  i+=1
                end
                data = StringIO.new('')
                book.write(data)  

                send_data(data.string, :filename => @student.name+'的谈话纪录'+".xls")
      }
      format.html
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student, :notice => '学生信息成功更新') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_scores
    student = Student.find(params[:student_id])
    student.assignments.delete_all
    params.each do |key,value|
      if key =~ /^course_(\d+)/
        next if value=="-1"
        Assignment.create!(student_id:student.id, course_id:$1.to_i, score:value)
      elsif key =~ /^new_course_(\d+)/
        next if params["new_course_score_#{$1}"]==""
        Assignment.create!(student_id:student.id, course_id:value.to_i, score:params["new_course_score_#{$1}"].to_i)
      end
    end
    redirect_to(student, :notice => '成绩信息成功更新')
  end
end
