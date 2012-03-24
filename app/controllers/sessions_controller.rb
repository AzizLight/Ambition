class SessionsController < ApplicationController
  layout 'sessions'

  def new
  end

  def create
    if login(params[:email], params[:password], params[:remember])
      flash[:success] = "Successfully logged in!"
      redirect_back_or_to admin_root_url
    else
      flash.now.alert = "Email/password combination is invalid!"
      render :new
    end
  end

  def destroy
    logout
    flash[:success] = "Successfully logged out!"
    redirect_to root_url
  end
end
