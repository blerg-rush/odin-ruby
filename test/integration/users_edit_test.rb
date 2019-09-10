require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "unsuccessful edit" do
    login_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "",
                                              email: "@invalid.com",
                                              password: "wrong",
                                              password_confirmation: "conf" } }
    assert_template "users/edit"
    assert_select "div#error_explanation", /The form contains 4 errors./
  end

  test "successful edit" do
    login_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    name = "Fooby Bar"
    email = "fooby@bars.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    login_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "Fooby Bar"
    email = "fooby@bars.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
