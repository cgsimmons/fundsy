class Reward < ApplicationRecord
  belongs_to :campaign
  validates :amount, numericality: { greater_than: 0 }
  validates :description, presence: true
end
