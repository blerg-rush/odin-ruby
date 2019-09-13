class User < ApplicationRecord
  has_secure_password
  before_create :remember

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def remember
      self.remember_digest = User.digest(User.new_token)
    end
end
