class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :require_login

  protected

  def admin?
    unless current_user.admin?
      flash[:warning] = "You are not allowed to access this page!"
      redirect_back_or_to admin_dashboard_index_url
    end
  end
end
