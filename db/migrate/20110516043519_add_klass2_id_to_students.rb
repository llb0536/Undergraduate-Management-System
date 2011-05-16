class AddKlass2IdToStudents < ActiveRecord::Migration
  def self.up
    add_column :students,:klass2_id,:integer
  end

  def self.down
    remove_column :students,:klass2_id
  end
end
