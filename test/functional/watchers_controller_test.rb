require 'test_helper'

class WatchersControllerTest < ActionController::TestCase
  setup do
    @watcher = watchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watcher" do
    assert_difference('Watcher.count') do
      post :create, watcher: { branch: @watcher.branch, full_repo: @watcher.full_repo }
    end

    assert_redirected_to watcher_path(assigns(:watcher))
  end

  test "should show watcher" do
    get :show, id: @watcher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watcher
    assert_response :success
  end

  test "should update watcher" do
    put :update, id: @watcher, watcher: { branch: @watcher.branch, full_repo: @watcher.full_repo }
    assert_redirected_to watcher_path(assigns(:watcher))
  end

  test "should destroy watcher" do
    assert_difference('Watcher.count', -1) do
      delete :destroy, id: @watcher
    end

    assert_redirected_to watchers_path
  end
end
