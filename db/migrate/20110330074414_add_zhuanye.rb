# -*- encoding : utf-8 -*-
class AddZhuanye < ActiveRecord::Migration
  def self.up
    add_column :students,:zhuanye_id,:integer
  end

  def self.down
    remove_column :students,:zhuanye_id
  end
end
