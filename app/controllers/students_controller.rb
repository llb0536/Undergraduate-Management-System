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
