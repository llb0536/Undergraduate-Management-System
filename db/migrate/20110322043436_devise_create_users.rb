# -*- encoding : utf-8 -*-
class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :name
      t.boolean :is_admin
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end
    
    add_index :users, :name,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    
    user = User.create!(:name=>'wangfeng',:email=>'whb_wf@yahoo.com.cn',:password=>'wangfeng');user.is_admin=true;user.save!
    user = User.create!(:name=>'psvr2001',:email=>'pmq2001@gmail.com',:password=>'pmqpmq55');user.is_admin=true;user.save!
  end

  def self.down
    drop_table :users
  end
end
