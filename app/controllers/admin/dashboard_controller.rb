class Admin::DashboardController < Admin::BaseController
  def index
    # Show the three most recent posts
    @posts = Post.limit(3)
  end
end
