class User < ApplicationRecord
  has_secure_password
  has_many :hosted_events, class_name: "Event", foreign_key: "host_id",
                           dependent: :destroy
  has_many :invitations, foreign_key: "attendee_id", dependent: :destroy
end
