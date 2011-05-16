# -*- encoding : utf-8 -*-
class Grade < ActiveRecord::Base
  has_many :klasses
  has_many :klass2s
end
