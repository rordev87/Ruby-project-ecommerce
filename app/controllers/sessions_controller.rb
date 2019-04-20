class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
       params[:session][:remember_me] == Settings.server.session.remember_me ?
        
		    remember(user) : forget(user)
        redirect_to root_path
      else
        @login_fails = I18n.t "controller.session.require_activated"
        render :new
      end
    else
      @login_fails = I18n.t "controller.session.login_fails"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end
