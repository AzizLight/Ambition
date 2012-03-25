class Admin::DashboardController < Admin::BaseController
  def index
    # Show the three most recent posts
    @post = Post.last
  end
end
