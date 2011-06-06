class CreateSeminars < ActiveRecord::Migration
  def self.up
    create_table :seminars do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :seminars
  end
end
