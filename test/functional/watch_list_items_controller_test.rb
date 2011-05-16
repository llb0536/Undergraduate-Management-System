# -*- encoding : utf-8 -*-
require 'test_helper'

class WatchListItemsControllerTest < ActionController::TestCase
  setup do
    @watch_list_item = watch_list_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watch_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watch_list_item" do
    assert_difference('WatchListItem.count') do
      post :create, :watch_list_item => @watch_list_item.attributes
    end

    assert_redirected_to watch_list_item_path(assigns(:watch_list_item))
  end

  test "should show watch_list_item" do
    get :show, :id => @watch_list_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @watch_list_item.to_param
    assert_response :success
  end

  test "should update watch_list_item" do
    put :update, :id => @watch_list_item.to_param, :watch_list_item => @watch_list_item.attributes
    assert_redirected_to watch_list_item_path(assigns(:watch_list_item))
  end

  test "should destroy watch_list_item" do
    assert_difference('WatchListItem.count', -1) do
      delete :destroy, :id => @watch_list_item.to_param
    end

    assert_redirected_to watch_list_items_path
  end
end
