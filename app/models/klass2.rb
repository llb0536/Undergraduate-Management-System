class Klass2 < ActiveRecord::Base
  has_many :students
  belongs_to :grade
end
