# -*- encoding : utf-8 -*-
class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :tables do |t|
      t.text :checked_grades,:checked_klasses,:checked_students,:checked_courses,:checked_courses_quan,:result
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tables
  end
end
