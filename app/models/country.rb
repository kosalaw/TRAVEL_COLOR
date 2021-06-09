class Country < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :alerts, dependent: :destroy
end
