# -*- encoding : utf-8 -*-
class Add2 < ActiveRecord::Migration
  def self.up
    add_column :students,:zyh,:string #070101
    add_column :students,:xsh,:string #305
    add_column :students,:sfl,:string #非师范
    add_column :students,:wlfl,:string #理
    add_column :students,:lqlb,:string #统招    
  end

  def self.down
    remove_column :students,:zyh
    remove_column :students,:xsh
    remove_column :students,:sfl
    remove_column :students,:wlfl
    remove_column :students,:lqlb
  end
end
