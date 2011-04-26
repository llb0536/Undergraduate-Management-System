# -*- encoding : utf-8 -*-
class AddFamilyNames < ActiveRecord::Migration
  def self.up
    FamilyName.create!(hanzi:'商',letter:'S')
    FamilyName.create!(hanzi:'隗',letter:'K')
    FamilyName.create!(hanzi:'喜',letter:'X')
  end

  def self.down
  end
end
