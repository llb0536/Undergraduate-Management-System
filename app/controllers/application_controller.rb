# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "您没有这个权限."
    redirect_to root_url
  end
protected
  def do_it(biao,default)
    cookies_biao = controller_name + '_' + biao.to_s
    unless params[biao]
      params[biao]=default
    else
      cookies[cookies_biao] = params[biao]
    end
    params[biao] = cookies[cookies_biao] if cookies[cookies_biao]
  end
end
