class Admin::PagesController < Admin::BaseController
  def index
    @title = "Pages"
    @pages = Page.order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @title = "New Page"
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      page_title = "<a href=\"#{edit_admin_page_url(@page)}\">#{@page.title}</a>"
      ActivityLog.create!(
        :name => "New Page",
        :description => "#{current_user.username} created a page: #{page_title}!",
        :entity => "page",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Page created successfully"
      redirect_to edit_admin_page_url(@page)
    else
      @title = "New Page"
      render :new
    end
  end

  def edit
    @title = "Edit Post"
    @page = Page.find_by_id(params[:id])
  end

  def update
    @page = Page.find_by_id(params[:id])
    if @page.update_attributes(params[:page])
      page_title = "<a href=\"#{edit_admin_page_url(@page)}\">#{@page.title}</a>"
      ActivityLog.create!(
        :name => "Updated Page",
        :description => "#{current_user.username} updated a page: #{page_title}!",
        :entity => "page",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Page updated successfully"
      redirect_to edit_admin_page_url(@page)
    else
      @title = "Edit Post"
      render :edit
    end
  end

  def delete
    @title = "Delete Post"
    @page = Page.find_by_id(params[:id])
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    if @page.destroy
      ActivityLog.create!(
        :name => "Deleted Page",
        :description => "#{current_user.username} deleted a page: #{@page.title}!",
        :entity => "page",
        :user_id => current_user.id,
        :ip_address => request.remote_ip
      )
      flash[:success] = "Page deleted successfully!"
      redirect_to admin_pages_url
    else
      redirect_to admin_page_url(@page), :alert => "Unable to delete the page..."
    end
  end
end
