# -*- encoding : utf-8 -*-
class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name,:number
      t.integer :credit
      t.boolean :in_plan
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
