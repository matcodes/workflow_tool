class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
	respond_to 'json'
  before_filter :set_current_user

  private
  def set_current_user
    User.current = current_user
  end

end
