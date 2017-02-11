class Vote < ApplicationRecord
  UP = 1
  DOWN = -1

  belongs_to :slack_user
  belongs_to :recognition

  validates :first_vote, inclusion: { in: [true, false].freeze }
  validates :point, presence: true, inclusion: { in: [UP, DOWN].freeze }
end