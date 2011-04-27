# -*- encoding : utf-8 -*-
class CreateResearches < ActiveRecord::Migration
  def self.up
    create_table :researches do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :researches
  end
end
