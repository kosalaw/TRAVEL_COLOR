class Review < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :stars, presence: true
  validates :content, presence: true
end
