require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "real.email42@thezone.ca",
                     password: "foobybar", password_confirmation: "foobybar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "x" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "mYeMaiL@GsMAil.cOM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@email.ca USER@eeeemail.COM A_UZ-r@gmail.co.uk
                         first.last@meel.ca orange+juise@store.to]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email valication should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_gmail.org user.name@example.
                           foo@bar..com valid@e_mail.ca email@goo+gle.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Testing post")
    assert_difference "Micropost.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    example = users(:example)
    other = users(:other)
    assert_not example.following?(other)
    example.follow(other)
    assert example.following?(other)
    assert other.followers.include?(example)
    example.unfollow(other)
    assert_not example.following?(other)
  end

  test "feed should have the right posts" do
    example = users(:example)
    other = users(:other)
    another = users(:another)
    # Posts from followed user
    another.microposts.each do |post_following|
      assert example.feed.include?(post_following)
    end
    # Posts from self
    example.microposts.each do |post_self|
      assert example.feed.include?(post_self)
    end
    # Posts from unfollowed user
    other.microposts.each do |post_unfollowed|
      assert_not example.feed.include?(post_unfollowed)
    end
  end
end
