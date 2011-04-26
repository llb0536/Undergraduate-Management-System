# -*- encoding : utf-8 -*-
class FamilyNameAddendum < ActiveRecord::Migration
  def self.up
    FamilyName.create!(hanzi:'巩',letter:'G')
    FamilyName.create!(hanzi:'芮',letter:'R')
    FamilyName.create!(hanzi:'衡',letter:'H')
    FamilyName.create!(hanzi:'红',letter:'H')
    FamilyName.create!(hanzi:'尚',letter:'S')
    FamilyName.create!(hanzi:'亢',letter:'K')
  end

  def self.down
  end
end
