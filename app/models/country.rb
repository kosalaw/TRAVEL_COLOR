class Country < ApplicationRecord
  has_many :reviews
  has_many :alerts
end
