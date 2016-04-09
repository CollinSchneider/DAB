class BannersController < ApplicationController

  def create
    banner = Banner.create(banner_params)
    check_banner_status(banner)
    redirect_to request.referrer
    flash[:success] = "Bannered Created!"
  end

  def check_banner_status(banner)
    if banner.status === 'Active'
      all_banners_pages = Banner.where('link_to = ? AND id != ?', banner.link_to, banner.id)
      all_banners_pages.each do |banner_page|
        banner_page.status = "Non-Active"
        banner_page.save
      end
    end
  end

  def update
    banner = Banner.find(params[:id])
    banner.update(banner_params)
    check_banner_status(banner)
    redirect_to request.referrer
    flash[:success] = "Bannered Updated!"
  end

  def destroy
    banner = Banner.find(params[:id])
    banner.delete
    redirect_to request.referrer
    flash[:success] = "Banner deleted!"
  end

  private
  def banner_params
    params.require(:banner).permit(:image, :description, :status, :link_to)
  end

end
