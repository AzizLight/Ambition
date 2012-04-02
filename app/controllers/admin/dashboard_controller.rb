class Admin::DashboardController < Admin::BaseController
  def index
    @title = "Dashboard"
    @post = Post.last
    @activity_logs = ActivityLog.order("created_at DESC").limit(3)
  end
end
