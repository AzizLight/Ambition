class SessionsController < ApplicationController
  layout 'sessions'

  def new
    redirect_back_or_to admin_root_url if logged_in?
    @header_title = "Login"
  end

  def create
    user = User.find_by_username(params[:email]) || User.find_by_email(params[:email])
    if user.suspended?
      flash[:warning] = "Your account have been suspended!"
      redirect_to login_url
    elsif login(params[:email], params[:password], params[:remember])
      flash[:success] = "Successfully logged in!"
      redirect_back_or_to admin_root_url
    else
      @header_title = "Login"
      flash.now[:error] = "Email/password combination is invalid!"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Successfully logged out!"
    redirect_to root_url
  end
end
