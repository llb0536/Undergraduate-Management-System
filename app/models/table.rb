# -*- encoding : utf-8 -*-
require 'json'
class Table < ActiveRecord::Base
  belongs_to :user
  before_create :make_name,:calculate
  
  def make_name
    self.name = ''
    self.name += self.klasses_join
    self.name += '学生'
    self.name += self.courses_join
    self.name += '课程成绩排名表'
  end
  
  def calculate
    discourse = Hash.new
    self.checked_courses_quan.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      discourse[$1]=$2
    end
    r = Hash.new
    reason = Hash.new
    self.checked_students.split(',').each do |str|
      str=~/"(\d+)"=>/
      student = Student.find($1)
      total = 0
      count = 0
      reason[student.id] = '('
      student.assignments.each do |ass|
        if discourse[ass.course_id.to_s]
          next if Course.find(ass.course_id).credit==0
          total += ass.score*discourse[ass.course_id.to_s].to_i
          reason[student.id] += ' + ' unless count == 0
          reason[student.id] += "#{ass.score}*#{discourse[ass.course_id.to_s].to_i}"
          count += ass.course.credit
        end
      end
      reason[student.id] += ") / #{count}"
      if count==0
        r[student.id]=0
      else
        r[student.id]=(total*1.0/count)
      end
    end
    r = r.sort_by{|k,v| -v}
    reasons = Array.new
    r.each do |k,v|
      reasons << reason[k]
    end
    self.result = r.to_json
    self.reason = reasons.to_json
  end
  
  def courses
    ret = Array.new
    self.checked_courses.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      ret << Courses.find($1)
    end
    ret
  end
  def courses_hash
    ret = Hash.new
    course_ids = Array.new
    self.checked_courses.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      course_ids << $1
    end
    self.checked_courses_quan.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      value = $2.to_i
      next unless value>0
      next unless course_ids.include? $1
      ret[Course.find($1)] = $2.to_i
    end
    ret
  end
  def klasses_join(delimiter='、',max=3)
    s=""
    i=0
    count = self.klasses.count
    self.klasses.each do |c|
      i+=1
      if i>max
        s+='等'
        break
      end
      s+=c.grade.name+'级'+c.name+'班'
      s+=delimiter unless i==count or i==max
    end
    s.strip
  end
  def courses_join(delimiter='、',max=3)
    s=""
    i=0
    count = self.courses.count
    self.courses.each do |c|
      i+=1
      if i>max
        s+='等'+count.to_s+'门'
        break
      end
      s+=c.name
      s+=delimiter unless i==count or i==max
    end
    s.strip
  end
  def klasses
    ret = Array.new
    self.checked_klasses.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      ret << Klass.find($1)
    end
    ret
  end
  def students
    ret = Array.new
    self.checked_students.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      ret << Student.find($1)
    end
    ret
  end
  def courses
    ret = Array.new
    self.checked_courses.split(',').each do |str|
      str=~/"(\d+)"=>"(\d+)"/
      ret << Course.find($1)
    end
    ret
  end
end
