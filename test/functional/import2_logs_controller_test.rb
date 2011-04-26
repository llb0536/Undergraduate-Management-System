# -*- encoding : utf-8 -*-
require 'test_helper'

class Import2LogsControllerTest < ActionController::TestCase
  setup do
    @import2_log = import2_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:import2_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create import2_log" do
    assert_difference('Import2Log.count') do
      post :create, :import2_log => @import2_log.attributes
    end

    assert_redirected_to import2_log_path(assigns(:import2_log))
  end

  test "should show import2_log" do
    get :show, :id => @import2_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @import2_log.to_param
    assert_response :success
  end

  test "should update import2_log" do
    put :update, :id => @import2_log.to_param, :import2_log => @import2_log.attributes
    assert_redirected_to import2_log_path(assigns(:import2_log))
  end

  test "should destroy import2_log" do
    assert_difference('Import2Log.count', -1) do
      delete :destroy, :id => @import2_log.to_param
    end

    assert_redirected_to import2_logs_path
  end
end
