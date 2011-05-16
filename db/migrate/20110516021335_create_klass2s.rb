class CreateKlass2s < ActiveRecord::Migration
  def self.up
    create_table :klass2s do |t|
      t.string :name
      t.integer :grade_id
      t.timestamps
    end
  end

  def self.down
    drop_table :klass2s
  end
end
