# -*- encoding : utf-8 -*-
require 'set'
class InquiryController < ApplicationController
  before_filter :authenticate_user!
  
  def watchlist
    render text:'开发中'
  end
  def talk
    render text:'开发中'
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
