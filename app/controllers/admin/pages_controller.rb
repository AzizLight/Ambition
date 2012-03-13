class Admin::PagesController < Admin::BaseController
  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:success] = "Page created successfully"
      redirect_to admin_page_path(@page)
    else
      render :new
    end
  end

  def show
    @page = Page.find_by_id(params[:id])
  end

  def edit
    @page = Page.find_by_id(params[:id])
  end

  def update
    @page = Page.find_by_id(params[:id])
    if @page.update_attributes(params[:page])
      flash[:success] = "Page updated successfully"
      redirect_to admin_page_path(@page)
    else
      render :edit
    end
  end

  def delete
    @page = Page.find_by_id(params[:id])
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    if @page.destroy
      flash[:success] = "Page deleted successfully!"
      redirect_to admin_pages_path
    else
      redirect_to admin_page_path(@page), :alert => "Unable to delete the page..."
    end
  end
end
