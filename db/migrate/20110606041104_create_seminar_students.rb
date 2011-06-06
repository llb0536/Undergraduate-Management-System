class CreateSeminarStudents < ActiveRecord::Migration
  def self.up
    create_table :seminars_students,:id=>false do |t|
      t.integer :seminar_id,:student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :seminars_students
  end
end
