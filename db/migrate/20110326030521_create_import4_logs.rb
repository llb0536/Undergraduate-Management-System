# -*- encoding : utf-8 -*-
class CreateImport4Logs < ActiveRecord::Migration
  def self.up
    create_table :import4_logs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :import4_logs
  end
end
