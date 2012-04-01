class PasswordResetsController < ApplicationController
  layout "sessions"

  def new
  end

  def create
    if params[:email].match /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
      @user = User.find_by_email(params[:email])
      @user.deliver_reset_password_instructions! if @user
      flash[:success] = "Instructions have been sent to your email."
      redirect_to root_path
    else
      flash.now[:error] = "Invalid Email Address"
      render :new
    end
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]

    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      flash[:success] = 'Password was successfully updated.'
      redirect_to root_path
    else
      @token = params[:token]
      render :action => "edit"
    end
  end
end
