class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def page_not_found
    {:file => "#{Rails.root}/public/404.html", :layout => false, :status => 404}
  end
end
