class User < ApplicationRecord
  validates :username, :presence
  validates :email, :presence
  validates :password, :presence
end
