# -*- encoding : utf-8 -*-
class AddValueToWarningXuefenStudents < ActiveRecord::Migration
  def self.up
    add_column :warning_xuefen_students,:val,:double
  end

  def self.down
    remove_column :warning_xuefen_students,:val
  end
end
