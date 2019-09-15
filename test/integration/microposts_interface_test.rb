require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
  end

  test "micropost interface" do
    login_as(@user)
    get root_path
    assert_select "div.pagination"
    assert_match @user.name, response.body
    assert_select "a", text: "view my profile", count: 1
    assert_match ActionController::Base.helpers.pluralize(@user.microposts.count,
                                                          "micropost"), response.body
    assert_select "input[type=file]"
    # Invalid sumission
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select "div#error_explanation"
    # Valid submission
    content = "This post is really super"
    picture = fixture_file_upload("test/fixtures/files/image.png", "image/png")
    assert_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: content, picture: picture } }
    end
    micropost = assigns(:micropost)
    assert micropost.picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select "a", text: "delete"
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different user (no delete links)
    get user_path(users(:fourth))
    assert_select "a", text: "delete", count: 0
  end
end
