# -*- encoding : utf-8 -*-
require 'test_helper'

class Import4LogsControllerTest < ActionController::TestCase
  setup do
    @import4_log = import4_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:import4_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create import4_log" do
    assert_difference('Import4Log.count') do
      post :create, :import4_log => @import4_log.attributes
    end

    assert_redirected_to import4_log_path(assigns(:import4_log))
  end

  test "should show import4_log" do
    get :show, :id => @import4_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @import4_log.to_param
    assert_response :success
  end

  test "should update import4_log" do
    put :update, :id => @import4_log.to_param, :import4_log => @import4_log.attributes
    assert_redirected_to import4_log_path(assigns(:import4_log))
  end

  test "should destroy import4_log" do
    assert_difference('Import4Log.count', -1) do
      delete :destroy, :id => @import4_log.to_param
    end

    assert_redirected_to import4_logs_path
  end
end
