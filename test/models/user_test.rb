require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Guinness", email: "delicious@beer.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    dupe_user = @user.dup
    dupe_user.email = @user.email.upcase
    @user.save
    assert_not dupe_user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_emails = %w[user@email.ca USER@eeeemail.COM A_UZ-r@gmail.co.uk
                      first.last@meel.ca orange+juise@store.to]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_emails = %w[user@example,com user_at_gmail.org user.name@example.
                        foo@bar..com valid@e_mail.ca email@goo+gle.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should be invalid"
    end
  end
end
