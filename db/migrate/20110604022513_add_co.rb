class AddCo < ActiveRecord::Migration
  def self.up
        drop_table :import3_logs
            drop_table :import4_logs
    create_table :import3_logs do |t|
      t.integer  "user_id"
      t.integer  "students_updated"
      t.integer  "students_created"
      t.boolean  "erroneous"

      t.timestamps
    end
    create_table :import4_logs do |t|
      t.integer  "user_id"
      t.integer  "students_updated"
      t.integer  "students_created"
      t.boolean  "erroneous"

      t.timestamps
    end
  end

  def self.down
    drop_table :import3_logs
        drop_table :import4_logs
  end
end
