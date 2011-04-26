# -*- encoding : utf-8 -*-
class CreateWarnings < ActiveRecord::Migration
  def self.up
    create_table :warnings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :warnings
  end
end
