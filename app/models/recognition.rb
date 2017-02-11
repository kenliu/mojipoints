class Recognition < ApplicationRecord
  has_many :votes
  has_many :slack_users, through: :votes

  validates :channel, :subject, :ts, presence: true
  validates :vote_direction, inclusion: { :in => [true, false] }
end
