require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
