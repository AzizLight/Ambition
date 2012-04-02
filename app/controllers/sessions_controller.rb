class SessionsController < ApplicationController
  layout 'sessions'

  def new
    redirect_back_or_to admin_root_url if logged_in?
    @header_title = "Login"
  end

  def create
    user = User.find_by_username(params[:email]) || User.find_by_email(params[:email])
    if user && user.suspended?
      flash[:warning] = "Your account have been suspended!"
      redirect_to login_url
    elsif login(params[:email], params[:password], params[:remember])
      # Add an activity log :-)
      ActivityLog.create!(
        :name => "Logged in",
        :description => "#{current_user.username} logged in!",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )

      flash[:success] = "Successfully logged in!"
      redirect_back_or_to admin_root_url
    else
      @header_title = "Login"
      flash.now[:error] = "Email/password combination is invalid!"
      render :new
    end
  end

  def destroy
    user = current_user
    logout
    # Add an activity log again :-)
    ActivityLog.create!(
      :name => "Logged out",
      :description => "#{user.username} logged out!",
      :entity => "user",
      :user_id => user.id,
      :ip_address => request.remote_ip
    )
    flash[:success] = "Successfully logged out!"
    redirect_to root_url
  end
end
