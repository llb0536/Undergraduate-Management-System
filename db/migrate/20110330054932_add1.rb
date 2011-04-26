# -*- encoding : utf-8 -*-
class Add1 < ActiveRecord::Migration
  def self.up
    add_column :students,:xsm,:string #数学科学学院
    add_column :students,:pyfs,:string #统招
    add_column :students,:nd,:string #2008
    add_column :students,:tzsh,:string #08010988
    add_column :students,:csrq,:string #19900619
    add_column :students,:rxny,:string #200809
    add_column :students,:bkzy1,:string
    add_column :students,:bkzy2,:string
    add_column :students,:bkzy3,:string
    add_column :students,:bkzy4,:string
    add_column :students,:bkzy5,:string
    add_column :students,:bkzy6,:string
  end

  def self.down
    remove_column :students,:xsm
    remove_column :students,:pyfs 
    remove_column :students,:nd
    remove_column :students,:tzsh
    remove_column :students,:csrq
    remove_column :students,:rxny
    remove_column :students,:bkzy1
    remove_column :students,:bkzy2
    remove_column :students,:bkzy3
    remove_column :students,:bkzy4
    remove_column :students,:bkzy5
    remove_column :students,:bkzy6
  end
end
