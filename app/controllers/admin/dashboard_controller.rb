class Admin::DashboardController < Admin::BaseController
  def index
    @title = "Dashboard"
    @post = Post.last
  end
end
