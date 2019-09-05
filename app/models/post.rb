class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true
  belongs_to :user
  validates :user, presence: true
end
