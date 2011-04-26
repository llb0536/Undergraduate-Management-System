# -*- encoding : utf-8 -*-
class NameToTables < ActiveRecord::Migration
  def self.up
    add_column :tables,:name,:string
  end

  def self.down
    remove_column :tables,:name
  end
end
