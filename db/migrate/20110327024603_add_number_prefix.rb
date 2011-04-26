# -*- encoding : utf-8 -*-
class AddNumberPrefix < ActiveRecord::Migration
  def self.up
    add_column :students,:number_prefix,:string
    add_column :courses,:number_prefix,:string
  end

  def self.down
    remove_column :students,:number_prefix
    remove_column :courses,:number_prefix
  end
end
