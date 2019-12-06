require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { email: "", password: "" } }
    assert_template
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "password" } }
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information then logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "password" } }
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_url
    # Simulate a user clocking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    login_as(@user, remember_me: 1)
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end

  test "login without remembering" do
    # Login to set the cookie
    login_as(@user, remember_me: 1)
    # Login again and verify the cookie is deleted
    login_as(@user, remember_me: 0)
    assert_empty cookies[:remember_token]
  end
end
