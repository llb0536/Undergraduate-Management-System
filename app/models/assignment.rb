# -*- encoding : utf-8 -*-
class Assignment < ActiveRecord::Base
  belongs_to :student,:counter_cache=>true
  belongs_to :course,:counter_cache=>true
  before_save :check_consistancy
  def check_consistancy
    return false unless Course.find(self.course_id) and Student.find(self.student_id)
    if Assignment.where(course_id:self.course_id,student_id:self.student_id).count>0
      Assignment.delete_all(course_id:self.course_id,student_id:self.student_id)
    end
    return true
  end
end
