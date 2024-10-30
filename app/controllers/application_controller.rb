class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  helper_method :admin_signed_in?, :authenticate_admin!

  def admin_signed_in?
    return true unless Rails.env.production? 

    authenticate_with_http_basic do |username, password|
      username == Rails.application.credentials.admin[:username] && 
        password == Rails.application.credentials.admin[:password]
    end
  end

  def authenticate_admin!
    return if Rails.env.production? # Optional: skip auth in development/test

    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.admin[:username] && 
        password == Rails.application.credentials.admin[:password]
    end
  end
end
