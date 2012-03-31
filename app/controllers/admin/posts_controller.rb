class Admin::PostsController < Admin::BaseController
  before_filter :restrict_access_to_authors, :only => [:edit, :update]
  before_filter :restrict_access_to_admins, :only => [:destroy]

  def index
    @title = "Posts"
    if current_user.admin?
      @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    else
      @posts = Post.where("user_id = ?", current_user.id).order("created_at DESC").page(params[:page]).per(10)
    end
  end

  def new
    @title = "New Post"
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "New Post"
      render :new
    end
  end

  def edit
    @title = "Edit Post"
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated successfully!"
      redirect_to admin_post_path(@post)
    else
      @title = "Edit Post"
      render :edit
    end
  end

  def delete
    @title = "Delete Post"
    @post = Post.find_by_id(params[:id])
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted successfully!"
      redirect_to admin_posts_path
    else
      redirect_to admin_post_path(@post), :alert => "Unable to delete the post..."
    end
  end

  private

  def restrict_access_to_authors
    @post = Post.find_by_id(params[:id])
    unless current_user.id == @post.user.id
      flash[:warning] = "You are not allowed to access this page!"
      redirect_back_or_to admin_posts_url
    end
  end

  def restrict_access_to_admins
    @post = Post.find_by_id(params[:id])
    unless current_user.admin?
      flash[:warning] = "You are not allowed to access this page!"
      redirect_back_or_to admin_posts_url
    end
  end
end
