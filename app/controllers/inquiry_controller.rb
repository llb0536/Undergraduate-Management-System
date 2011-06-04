# -*- encoding : utf-8 -*-
require 'set'
require 'spreadsheet'

class InquiryController < ApplicationController
  before_filter :authenticate_user!
  
  def watchlist
    render text:'开发中'
  end
  def talk
    @talk_records = TalkRecord.order('happened_at DESC')
    respond_to do |format|
      format.xls{
                Spreadsheet.client_encoding = 'UTF-8'
                book = Spreadsheet::Workbook.new
                data = StringIO.new('')
                sheet1 = book.create_worksheet :name => '全部谈话纪录'
                sheet1.row(0).replace %w{发生日期 学生 谈话人 内容摘要 备注}
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
            		@talk_records.each do |talk_record|
            		  sheet1.row(i).replace [talk_record.happened_at.strftime("%Y年%m月%d日"),
            		    talk_record.student.name,
            		    talk_record.talker,
            		    talk_record.about,
            		    talk_record.memo]
            		  sheet1.row(i).set_format(0, bold)
            		  i+=1
                end
                data = StringIO.new('')
                book.write(data)  

                send_data(data.string, :filename => "全部谈话纪录.xls")
      }
      format.html
    end
  end
  def graduate
    render text:'开发中'
  end
  
  def table
    @grades=Grade.all
  end
  
  def tableStep1
    @klasses = Array.new
    params[:checked_grades].each do |key,value|
      next unless value=="1"
      @klasses.concat Grade.find(key).klasses
    end
  end
  
  def tableStep2
    @students  =Array.new
    params[:checked_klasses].each do |key,value|
      next unless value=="1"
      @students.concat Klass.find(key).students
    end
  end
  
  def tableStep3
    @courses = Hash.new(0)
    @stu_count = params[:checked_students].count
    params[:checked_students].each do |key,value|
      next unless value=="1"
      Student.find(key).courses.each do |course|
        @courses[course.id] += 1
      end
    end
    @courses = @courses.sort_by {|key,value| -value}
  end
  
  def tableFinish
    courses = Array.new
    params[:checked_courses].to_s.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      courses << $1
    end
    
    @courses_hash = Hash.new
    params[:quan].to_s.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      value = $2.to_i
      next unless value>0
      next unless courses.include? $1
      @courses_hash[Course.find($1)] = $2.to_i
    end
  end
  
  def tableConfirmed
    t = Table.new
    t.checked_grades = params[:checked_grades].to_s
    t.checked_klasses	= params[:checked_klasses].to_s
    t.checked_students = params[:checked_students].to_s
    t.checked_courses = params[:checked_courses].to_s
    t.checked_courses_quan = params[:checked_courses_quan].to_s
    t.user_id = current_user.id
    t.save!
    redirect_to t
  end
end
