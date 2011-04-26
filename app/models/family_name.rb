# -*- encoding : utf-8 -*-
class FamilyName < ActiveRecord::Base
  scope :existings,where(:exists=>true).order('letter')
  def FamilyName.letExist!(surname)
    fn = FamilyName.find_by_hanzi(surname)
    fn ||= FamilyName.create!(hanzi:surname,letter:'-')
    fn.exists = true
    fn.save!
  end
end
