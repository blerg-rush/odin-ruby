class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: "User"

  enum status: { pending: 0,
                 accepted: 1,
                 declined: 2 }

  def accept!
    return false if accepted?

    update(status: "accepted")
  end

  def decline!
    return false if declined?

    update(status: "declined")
  end

  def accepted?
    status == "accepted"
  end

  def pending?
    status == "pending"
  end

  def declined?
    status == "declined"
  end
end
