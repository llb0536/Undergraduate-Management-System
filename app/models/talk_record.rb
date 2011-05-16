# -*- encoding : utf-8 -*-
class TalkRecord < ActiveRecord::Base
  belongs_to :student
  validates_presence_of :talker
  validates_presence_of :student_id
  validates_presence_of :happened_at
  validates_presence_of :about
end
