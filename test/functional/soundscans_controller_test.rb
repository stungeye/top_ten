require 'test_helper'

class SoundscansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:soundscans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create soundscan" do
    assert_difference('Soundscan.count') do
      post :create, :soundscan => { }
    end

    assert_redirected_to soundscan_path(assigns(:soundscan))
  end

  test "should show soundscan" do
    get :show, :id => soundscans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => soundscans(:one).to_param
    assert_response :success
  end

  test "should update soundscan" do
    put :update, :id => soundscans(:one).to_param, :soundscan => { }
    assert_redirected_to soundscan_path(assigns(:soundscan))
  end

  test "should destroy soundscan" do
    assert_difference('Soundscan.count', -1) do
      delete :destroy, :id => soundscans(:one).to_param
    end

    assert_redirected_to soundscans_path
  end
end
