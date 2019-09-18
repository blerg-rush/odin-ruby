class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token
  validates :name, presence: true, uniqueness: { case_sensitive: false },
                   format: { without: /\s/ }
  validates :password, presence: true
  has_many :hosted_events, class_name: "Event", foreign_key: "host_id",
                           dependent: :destroy
  has_many :invitations, foreign_key: "attendee_id", dependent: :destroy

  def upcoming_events
    hosted_events.where("events.date > ?", Time.zone.now)
  end

  def past_events
    hosted_events.where("events.date <= ?", Time.zone.now).reverse_order
  end

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
