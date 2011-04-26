# -*- encoding : utf-8 -*-
class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :course_id,:student_id
      t.integer :score
      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
