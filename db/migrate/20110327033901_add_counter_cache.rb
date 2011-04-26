# -*- encoding : utf-8 -*-
class AddCounterCache < ActiveRecord::Migration
  def self.up
    add_column :students,:assignments_count,:integer
    add_column :courses,:assignments_count,:integer
  end

  def self.down
    remove_column :students,:assignments_count
    remove_column :courses,:assignments_count
  end
end
