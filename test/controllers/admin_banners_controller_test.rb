require 'test_helper'

class AdminBannersControllerTest < ActionController::TestCase
  setup do
    @admin_banner = admin_banners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_banners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_banner" do
    assert_difference('AdminBanner.count') do
      post :create, admin_banner: { active: @admin_banner.active, banner: @admin_banner.banner }
    end

    assert_redirected_to admin_banner_path(assigns(:admin_banner))
  end

  test "should show admin_banner" do
    get :show, id: @admin_banner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_banner
    assert_response :success
  end

  test "should update admin_banner" do
    patch :update, id: @admin_banner, admin_banner: { active: @admin_banner.active, banner: @admin_banner.banner }
    assert_redirected_to admin_banner_path(assigns(:admin_banner))
  end

  test "should destroy admin_banner" do
    assert_difference('AdminBanner.count', -1) do
      delete :destroy, id: @admin_banner
    end

    assert_redirected_to admin_banners_path
  end
end
