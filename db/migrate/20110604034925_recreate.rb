class Recreate < ActiveRecord::Migration
  def self.up
      create_table :import5_logs do |t|
        t.integer  "user_id"
        t.integer  "students_updated"
        t.integer  "students_created"
        t.boolean  "erroneous"

        t.timestamps
      end
      create_table :import6_logs do |t|
        t.integer  "user_id"
        t.integer  "students_updated"
        t.integer  "students_created"
        t.boolean  "erroneous"

        t.timestamps
      end
      create_table :import7_logs do |t|
        t.integer  "user_id"
        t.integer  "students_updated"
        t.integer  "students_created"
        t.boolean  "erroneous"

        t.timestamps
      end
    end

  end

  def self.down
    drop_table :import5_logs
    drop_table :import6_logs
    drop_table :import7_logs
  end
end

