# -*- encoding : utf-8 -*-
class Grade < ActiveRecord::Base
  has_many :klasses
end
