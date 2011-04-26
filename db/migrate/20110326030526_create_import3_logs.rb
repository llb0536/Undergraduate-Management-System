# -*- encoding : utf-8 -*-
class CreateImport3Logs < ActiveRecord::Migration
  def self.up
    create_table :import3_logs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :import3_logs
  end
end
