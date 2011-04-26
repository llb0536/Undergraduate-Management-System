# -*- encoding : utf-8 -*-
require 'test_helper'

class Import3LogsControllerTest < ActionController::TestCase
  setup do
    @import3_log = import3_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:import3_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create import3_log" do
    assert_difference('Import3Log.count') do
      post :create, :import3_log => @import3_log.attributes
    end

    assert_redirected_to import3_log_path(assigns(:import3_log))
  end

  test "should show import3_log" do
    get :show, :id => @import3_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @import3_log.to_param
    assert_response :success
  end

  test "should update import3_log" do
    put :update, :id => @import3_log.to_param, :import3_log => @import3_log.attributes
    assert_redirected_to import3_log_path(assigns(:import3_log))
  end

  test "should destroy import3_log" do
    assert_difference('Import3Log.count', -1) do
      delete :destroy, :id => @import3_log.to_param
    end

    assert_redirected_to import3_logs_path
  end
end
