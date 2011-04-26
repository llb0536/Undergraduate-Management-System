# -*- encoding : utf-8 -*-
class Course < ActiveRecord::Base
  has_many :assignments
  has_many :students,:through=>:assignments
  before_save :set_number_prefix
  
  def Course.inside_types
    return ['通识教育必修','教师教育系列','实践教学','专业基础必修','专业基础选修','专业核心','专业方向必修','专业方向选修','人文社会科学系列','科学技术系列','语言系列','艺术教育系列','体育与健康系列']
  end
protected
  def set_number_prefix
    self.number_prefix = self.number[0..2]
  end
end
