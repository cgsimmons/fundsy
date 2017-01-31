class Campaign < ApplicationRecord
  belongs_to :user
  has_many :pledges, dependent: :destroy
  has_many :rewards, dependent: :destroy
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, uniqueness: true
  validates :goal, numericality: { greater_than_or_equal_to: 10 }

  include AASM
  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :canceled
    state :funded
    state :unfunded

    event :publish do
      transitions from: :draft, to: :published
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :unfund do
      transitions from: :published, to: :unfunded
    end

    event :cancel do
      transitions from: [:draft, :published, :funded], to: :canceled
    end

    event :relaunch do
      transitions from: :canceled, to: :draft
    end
  end


  def titleized_title
    title.titleize
  end
end
