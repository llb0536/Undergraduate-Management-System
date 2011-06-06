class Addddd < ActiveRecord::Migration
  def self.up
    add_column :seminars,:memo,:string
  end

  def self.down
    remove_column :seminars,:memo
  end
end
