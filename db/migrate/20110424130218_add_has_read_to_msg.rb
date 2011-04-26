# -*- encoding : utf-8 -*-
class AddHasReadToMsg < ActiveRecord::Migration
  def self.up
    add_column :messages,:has_read,:boolean
  end

  def self.down
    remove_column :messages,:has_read
  end
end
