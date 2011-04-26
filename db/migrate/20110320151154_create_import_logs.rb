# -*- encoding : utf-8 -*-
class CreateImportLogs < ActiveRecord::Migration
  def self.up
    create_table :import_logs do |t|
      t.integer :user_id
      t.string :filename,:grade_created,:klass_created
      t.integer :course_created_count,:stu_created_count,:co_count,:co_no_count
      t.boolean :erroneous
      t.timestamps
    end
  end

  def self.down
    drop_table :import_logs
  end
end
