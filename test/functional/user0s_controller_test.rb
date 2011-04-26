# -*- encoding : utf-8 -*-
require 'test_helper'

class User0sControllerTest < ActionController::TestCase
  setup do
    @user0 = user0s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user0s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user0" do
    assert_difference('User0.count') do
      post :create, :user0 => @user0.attributes
    end

    assert_redirected_to user0_path(assigns(:user0))
  end

  test "should show user0" do
    get :show, :id => @user0.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user0.to_param
    assert_response :success
  end

  test "should update user0" do
    put :update, :id => @user0.to_param, :user0 => @user0.attributes
    assert_redirected_to user0_path(assigns(:user0))
  end

  test "should destroy user0" do
    assert_difference('User0.count', -1) do
      delete :destroy, :id => @user0.to_param
    end

    assert_redirected_to user0s_path
  end
end
