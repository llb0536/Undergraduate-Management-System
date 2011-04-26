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
    do_it(:per,25)
    @students = Student
    @students = @students.where(klass_id:Grade.find(params[:grade_id]).klasses.collect(&:id)) if params[:grade_id]
    @students = @students.where(klass_id:params[:klass_id]) if params[:klass_id]
    @students = @students.where(paixuzi:params[:paixuzi]) if params[:paixuzi]
    @students = @students.where(surname:FamilyName.find(params[:surname_id]).hanzi) if params[:surname_id]
    @students = @students.where(number_prefix:params[:number_prefix]) if params[:number_prefix]
    @students = @students.order(params[:order])
    @students = @students.page(params[:page]).per(params[:per])
    @order = params[:order]
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @yixiu=0;@student.assignments.where('score>=60').each{|ass| @yixiu+=ass.course.credit}
    @bujige=0;@student.assignments.where('score<60').each{|ass| @bujige+=ass.course.credit}
    @has_xueqi = 1
    @has_xueqi = Time.now.strftime("%y").to_i - @student.klass.grade.name.to_i if @student.klass and @student.klass.grade
    @has_xueqi *= 2
    @has_xueqi -= 1 if Time.now.strftime("%m").to_i < 9
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
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
        format.html { redirect_to(@student, :notice => 'Student was successfully updated.') }
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
end
