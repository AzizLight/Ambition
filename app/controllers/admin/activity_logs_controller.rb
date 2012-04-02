class Admin::ActivityLogsController < Admin::BaseController

  def index
    @title = "Activity Logs"
    @activity_logs = ActivityLog.page(params[:page]).per(20)
  end

  def clear
    if ActivityLog.destroy_all
      ActivityLog.create!(
        :name => "Activity log cleared",
        :description => "#{current_user.username} cleared the logs.",
        :entity => "log",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Successfully cleared the logs"
      redirect_to admin_activity_logs_url
    end
  end
end
