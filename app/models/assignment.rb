# -*- encoding : utf-8 -*-
class Assignment < ActiveRecord::Base
  belongs_to :student,:counter_cache=>true
  belongs_to :course,:counter_cache=>true
end
