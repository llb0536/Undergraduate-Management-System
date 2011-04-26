# -*- encoding : utf-8 -*-
class AddReasonToTable < ActiveRecord::Migration
  def self.up
    add_column :tables,:reason,:text
  end

  def self.down
    remove_column :tables,:reason
  end
end
