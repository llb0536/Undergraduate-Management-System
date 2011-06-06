# -*- encoding : utf-8 -*-
class Student < ActiveRecord::Base
  has_and_belongs_to_many :seminars
  belongs_to :klass
  belongs_to :klass2
  belongs_to :zhuanye
  has_many :scholarships
  has_many :assignments
  has_many :talk_records
  has_many :courses,:through=>:assignments
  before_save :set_paixuzi,:set_surname,:set_number_prefix
  def yixiu
    ret = 0
    self.assignments.where('score>=60').each{|ass| ret+=ass.course.credit}
    ret
  end
  def bujige
    ret = 0
    self.assignments.where('score<60').each{|ass| ret+=ass.course.credit}
    ret
  end
  def has_xueqi
  	ret = 1
    ret = Time.now.strftime("%y").to_i - self.klass.grade.name.to_i if self.klass and self.klass.grade
    ret *= 2
    ret -= 1 if Time.now.strftime("%m").to_i < 9
  end
  def xb
    if self.is_male
      return '男'
    else
      return '女'
    end
  end
  def banji
    s=''
    if self.klass and self.klass.grade
			s+=self.klass.grade.name+'级'
		end
		s+=self.klass.name+'班' if self.klass
		s
	end
protected
  def set_paixuzi
    family_name = FamilyName.find_by_hanzi(self.name[0])
    if family_name
      self.paixuzi=family_name.letter
    else
      self.paixuzi='-'
    end
  end
  
  def set_surname
    self.surname = self.name[0]
  end
  
  def set_number_prefix
    self.number_prefix = self.number[0..6]
  end
end
