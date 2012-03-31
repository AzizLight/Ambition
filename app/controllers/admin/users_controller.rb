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
      flash[:success] = "User suspended successfully!"
    end

    redirect_back_or_to admin_users_url
  end

  def activate
    user = User.find_by_id(params[:user_id])

    if user.active?
      flash[:error] = "You can't activate a user that is already active!"
    else user.admin?
      user.activate
      flash[:success] = "User activated successfully!"
    end

    redirect_back_or_to admin_users_url
  end

  private

  def admin?
    unless current_user.admin?
      flash[:warning] = "You are not allowed to access this page!"
      redirect_back_or_to admin_dashboard_index_url
    end
  end
end
