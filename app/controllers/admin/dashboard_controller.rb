class Admin::DashboardController < Admin::BaseController
  def index
    @title = "Dashboard"
    @post = Post.last
    @activity_logs = ActivityLog.limit(3)
  end
end
