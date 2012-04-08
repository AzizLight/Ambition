class Admin::UsersController < Admin::BaseController
  before_filter :admin?

  def index
    @title = "Users"
    @users = User.order("username ASC").page(params[:page]).per(10)
  end

  def show
    @user = User.find_by_id(params[:id])
    @title = @user.username
  end

  def new
    @title = "New User"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      ActivityLog.create!(
        :name => "User created",
        :description => "#{current_user.username} created a new user: <a href=\"#{admin_user_path(@user)}\">#{@user.username}</a>.",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "User created successfully!"
      redirect_to root_url
    else
      @title = "New User"
      render :new
    end
  end

  def edit
    @title = "Edit User"
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated successfully!"
      redirect_to admin_user_url(@user)
    else
      @title = "Edit User"
      render :edit
    end
  end

  def suspend
    user = User.find_by_id(params[:user_id])

    if user.id == current_user.id
      flash[:error] = "You can't suspend yourself"
    elsif user.suspended?
      flash[:error] = "You can't suspend a user that is already suspended!"
    else
      user.suspend
      ActivityLog.create!(
        :name => "User suspended!",
        :description => "#{current_user.username} suspended #{user.username}.",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "User suspended successfully!"
    end

    redirect_back_or_to admin_users_url
  end

  def activate
    user = User.find_by_id(params[:user_id])

    if user.active?
      flash[:error] = "You can't activate a user that is already active!"
    else
      user.activate
      ActivityLog.create!(
        :name => "User activated!",
        :description => "#{current_user.username} activated #{user.username}.",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "User activated successfully!"
    end

    redirect_back_or_to admin_users_url
  end

  def adminize
    user = User.find_by_id(params[:user_id])

    if user.admin?
      flash[:error] = "You can't turn an admin into an admin!"
    elsif current_user.admin? && user.adminize
      ActivityLog.create!(
        :name => "User turned into admin!",
        :description => "#{current_user.username} turned #{user.username} into an admin.",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "User adminized successfully!"
    end

    redirect_back_or_to admin_users_url
  end

  def deadminize
    user = User.find_by_id(params[:user_id])

    if !user.admin?
      flash[:error] = "You can't turn a regular user into a regular user!"
    elsif current_user.admin? && user.deadminize
      ActivityLog.create!(
        :name => "Admin turned into a regular user!",
        :description => "#{current_user.username} turned #{user.username} into a regular user.",
        :entity => "user",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "User deadminized successfully!"
    end

    redirect_back_or_to admin_users_url
  end
end
