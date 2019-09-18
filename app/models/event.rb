class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations
  default_scope { order(:date) }
  scope :upcoming, -> { where("events.date > ?", Time.zone.now) }
  scope :past,     -> { where("events.date <= ?", Time.zone.now).reverse_order }
  validates :title, presence: true
  validates :date, presence: true

  def invitation_pending?(user)
    invitations.find_by(attendee_id: user.id).status == "pending" && 
      not_host?(user)
  end

  def invitation_declined?(user)
    invitations.find_by(attendee_id: user.id).status == "declined" &&
      not_host?(user)
  end

  def invitation_accepted?(user)
    invitations.find_by(attendee_id: user.id).status == "accepted" && 
      not_host?(user)
  end

  def not_invited?(user)
    !attendees.include?(user) && not_host?(user)
  end

  def host?(user)
    user == host
  end

  def not_host?(user)
    user != host
  end
end
