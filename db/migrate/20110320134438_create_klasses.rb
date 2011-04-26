# -*- encoding : utf-8 -*-
class CreateKlasses < ActiveRecord::Migration
  def self.up
    create_table :klasses do |t|
      t.string :name
      t.integer :grade_id
      t.timestamps
    end
  end

  def self.down
    drop_table :klasses
  end
end
