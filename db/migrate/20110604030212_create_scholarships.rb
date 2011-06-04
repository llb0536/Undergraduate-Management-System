class CreateScholarships < ActiveRecord::Migration
  def self.up
    create_table :scholarships do |t|
      t.integer :student_id
      t.string :level
      t.integer :acount

      t.timestamps
    end
  end

  def self.down
    drop_table :scholarships
  end
end
