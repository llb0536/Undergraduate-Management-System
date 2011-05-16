# -*- encoding : utf-8 -*-
class AddTalkerToTalkRecords < ActiveRecord::Migration
  def self.up
    add_column :talk_records,:happened_at,:date
    add_column :talk_records,:talker,:string
  end

  def self.down
    remove_column :talk_records,:happend_at
    remove_column :talk_records,:talker
  end
end
