class SessionsController < Devise::SessionsController
  
  protected

  def login_page?
    true
  end
end