class Recognition < ApplicationRecord
  has_many :slack_users, through: :votes
  has_many :votes

  validates :channel, :subject, :ts, presence: true
  validates :user_subject, inclusion: { in: [true, false], message: 'must be true or false' }
  validates :vote_direction, inclusion: { in: [true, false], message: 'must be true or false' }
end