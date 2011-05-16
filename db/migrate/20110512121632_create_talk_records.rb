# -*- encoding : utf-8 -*-
class CreateTalkRecords < ActiveRecord::Migration
  def self.up
    create_table :talk_records do |t|
      t.integer :student_id
      t.string :about
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :talk_records
  end
end
