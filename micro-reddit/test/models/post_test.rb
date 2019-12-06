require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(title: "Guinness", url: "www.guinness.com",
                     body: "This is just a test post.", user: User.new)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = " "
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 256
  end

  test "url should be present" do
    @post.url = " "
    assert_not @post.valid?
  end
end
