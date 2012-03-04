class Admin::UsersController < Admin::BaseController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User created successfully!"
      redirect_to root_url
    else
      render :new
    end
  end
end
