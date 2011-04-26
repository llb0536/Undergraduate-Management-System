# -*- encoding : utf-8 -*-
class CreateImport2Logs < ActiveRecord::Migration
  def self.up
    create_table :import2_logs do |t|
      t.integer :user_id
      t.integer :students_updated,:students_created
      t.boolean :erroneous
      t.timestamps
    end
  end

  def self.down
    drop_table :import2_logs
  end
end
