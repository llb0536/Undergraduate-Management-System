# -*- encoding : utf-8 -*-
class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name,:surname,:number,:bj,:sfh,:mz,:jg,:sbzzmm,:zy,:ksh,:zym,:kq,:wyyz,:lxrxm,:lxrdz,:lxryb,:lxrdh,:kslb,:byzx,:byzxyb,:brtc,:jlcc,:kstz,:tjjljs,:tjsxbzm,:yhkszss,:paixuzi
      t.text :ksjl
      t.boolean :is_male
      t.integer :klass_id,:fenshuxian,:rxzf,:gkzf,:fjf,:yw,:sx,:wy,:wl,:hx,:zz,:ls,:zh
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
