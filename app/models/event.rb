class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations
end
