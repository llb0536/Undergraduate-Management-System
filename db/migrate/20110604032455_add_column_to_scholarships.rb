class AddColumnToScholarships < ActiveRecord::Migration
  def self.up
    add_column :scholarships,:event,:string
  end

  def self.down
    remove_column :scholarships,:event
  end
end
