# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def menu
    render :layout=>false
  end
  
  def top
    render :layout=>false
  end
  
  def index
    render :layout=>false
  end
  
  def main
    @unread_msg = current_user.messages.where(has_read:false)
  end
  
  def import
  end
  
  def import2
  end

  def import3
  end
  
  def import4
  end
  
  def settings
    render text:'开发中'
  end
  
  def auto_import
    if 2==params[:type].to_i
      @action = '/core/import2'
      paths = Dir.glob("#{RAILS_ROOT}/data/info/*.xls")
    elsif 1==params[:type].to_i
      @action = '/core/import'
      paths = Dir.glob("#{RAILS_ROOT}/data/score/*.xls")
    else
      render :text=>'type wrong.' and return
    end
    @filepath = paths[params[:i].to_i]
  end
end
