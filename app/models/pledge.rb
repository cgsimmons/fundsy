class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  validates :amount, numericality: {greater_than_or_equal_to: 1}

end
