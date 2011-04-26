# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,:name, :password, :password_confirmation, :remember_me
  has_many :import_logs
  has_many :import2_logs
  has_many :tables
  has_many :messages
  has_many :sent_messages,:class_name=>'Message',:foreign_key=>'from_user_id'
  validates_uniqueness_of :name
end
