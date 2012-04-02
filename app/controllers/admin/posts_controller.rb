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
      post_title = (@post.user.id == current_user.id || current_user.admin?) ? "<a href=\"#{edit_admin_post_url(@post)}\">#{@post.title}</a>" : @post.title
      ActivityLog.create!(
        :name => "New post",
        :description => "#{current_user.username} created a new post: #{post_title}",
        :entity => "post",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Post created successfully!"
      redirect_to edit_admin_post_url(@post)
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
      post_title = (@post.user.id == current_user.id || current_user.admin?) ? "<a href=\"#{edit_admin_post_url(@post)}\">#{@post.title}</a>" : @post.title
      ActivityLog.create!(
        :name => "Updated post",
        :description => "#{current_user.username} updated a post: #{post_title}",
        :entity => "post",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Post updated successfully!"
      redirect_to edit_admin_post_url(@post)
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
      ActivityLog.create!(
        :name => "Deletd post",
        :description => "#{current_user.username} deleted a post: #{@post.title}",
        :entity => "post",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Post deleted successfully!"
      redirect_to admin_posts_url
    else
      redirect_to admin_posts_url, :alert => "Unable to delete the post..."
    end
  end

  private

  def restrict_access_to_authors
    @post = Post.find_by_id(params[:id])
    unless current_user.id == @post.user.id || current_user.admin?
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
