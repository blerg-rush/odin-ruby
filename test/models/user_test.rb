require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "real.email42@thezone.ca")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
