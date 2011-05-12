require 'test_helper'

class TalkRecordsControllerTest < ActionController::TestCase
  setup do
    @talk_record = talk_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:talk_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create talk_record" do
    assert_difference('TalkRecord.count') do
      post :create, :talk_record => @talk_record.attributes
    end

    assert_redirected_to talk_record_path(assigns(:talk_record))
  end

  test "should show talk_record" do
    get :show, :id => @talk_record.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @talk_record.to_param
    assert_response :success
  end

  test "should update talk_record" do
    put :update, :id => @talk_record.to_param, :talk_record => @talk_record.attributes
    assert_redirected_to talk_record_path(assigns(:talk_record))
  end

  test "should destroy talk_record" do
    assert_difference('TalkRecord.count', -1) do
      delete :destroy, :id => @talk_record.to_param
    end

    assert_redirected_to talk_records_path
  end
end
