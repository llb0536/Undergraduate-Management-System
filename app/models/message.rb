# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender,:class_name=>'User',:foreign_key=>'from_user_id'
  validates_presence_of :title
  validates_presence_of :user_id
end
