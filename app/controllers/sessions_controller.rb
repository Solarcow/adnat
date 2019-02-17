class SessionsController < ApplicationController
  def new
  end

  #finds a user then logs them if they authenticate successfully
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     log_in user
     # remembers the user if the "remember me box is checked"
     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
     redirect_to user
    else
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  # used to log a user out of their session
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
