# -*- encoding : utf-8 -*-
class Klass < ActiveRecord::Base
  belongs_to :grade
  has_many :students
  def banji
    s = ""
    s += "#{self.grade.name}级" if self.grade
    s += "#{self.name}班"
  end
end
