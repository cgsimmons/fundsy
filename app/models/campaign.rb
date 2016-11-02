class Campaign < ApplicationRecord
  belongs_to :user
  has_many :pledges, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :goal, numericality: {greater_than_or_equal_to: 10}


  def titleized_title
    self.title.titleize
  end
end
