# -*- encoding : utf-8 -*-
class CreateWarningXuefenStudents < ActiveRecord::Migration
  def self.up
    create_table :warning_xuefen_students do |t|
      t.integer :student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :warning_xuefen_students
  end
end
