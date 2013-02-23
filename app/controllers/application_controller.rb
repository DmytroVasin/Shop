class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :login_page?

  protected

  def login_page?
    false
  end
end
