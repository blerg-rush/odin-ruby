class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: 'Airport', foreign_key: :from_id
  belongs_to :to_airport, class_name: 'Airport', foreign_key: :to_id
end
