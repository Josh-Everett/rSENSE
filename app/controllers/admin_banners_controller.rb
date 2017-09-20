class AdminBannersController < ApplicationController
  #before_action :set_admin_banner, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_admin, only: [:index]
  skip_before_filter :authorize, only: [:show, :index]

  respond_to :html

  def index
    @admin_banners = AdminBanner.all
    redirect_to "/admin_banners/new"
  end

  def new
    @admin_banner = AdminBanner.new
    respond_with(@admin_banner)
  end

  def create
    @admin_banner = AdminBanner.new(admin_banner_params)
    @admin_banner.save
    redirect_to "/"
  end

  def update
    @admin_banner.update(admin_banner_params)
    respond_with(@admin_banner)
  end

  def destroy
    @admin_banner.destroy
    respond_with(@admin_banner)
  end

  private
    def set_admin_banner
      @admin_banner = AdminBanner.find(params[:id])
    end

    def admin_banner_params
      params.require(:admin_banner).permit(:active, :banner, :stylechoice)
    end
end
