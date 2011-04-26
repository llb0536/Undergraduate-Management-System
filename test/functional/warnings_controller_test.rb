# -*- encoding : utf-8 -*-
require 'test_helper'

class WarningsControllerTest < ActionController::TestCase
  setup do
    @warning = warnings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warnings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warning" do
    assert_difference('Warning.count') do
      post :create, :warning => @warning.attributes
    end

    assert_redirected_to warning_path(assigns(:warning))
  end

  test "should show warning" do
    get :show, :id => @warning.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @warning.to_param
    assert_response :success
  end

  test "should update warning" do
    put :update, :id => @warning.to_param, :warning => @warning.attributes
    assert_redirected_to warning_path(assigns(:warning))
  end

  test "should destroy warning" do
    assert_difference('Warning.count', -1) do
      delete :destroy, :id => @warning.to_param
    end

    assert_redirected_to warnings_path
  end
end
