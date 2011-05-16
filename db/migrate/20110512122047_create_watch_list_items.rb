# -*- encoding : utf-8 -*-
class CreateWatchListItems < ActiveRecord::Migration
  def self.up
    create_table :watch_list_items do |t|
      t.integer :student_id

      t.timestamps
    end
  end

  def self.down
    drop_table :watch_list_items
  end
end
