class WelcomeController < ApplicationController
  layout "application" 
  
  before_filter :authenticate_user!, :except => [:login, :reset_password]

  def index
    User.current = current_user
    render :inline => "<%= netzke :main_application %>", :layout => true
  end

  def login
    render :inline => "<%= netzke :login %>", :layout => true
  end

  def reset_password
    render :inline => "<%=netzke :reset_password %>", :layout => true
  end
end
