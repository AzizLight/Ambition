class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to admin_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated successfully!"
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end

  def delete
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
end
