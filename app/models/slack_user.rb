class SlackUser < ApplicationRecord
  has_many :votes

  validates :slack_userid, presence: true
  validates :slack_userid, format: { with: /U\w+/ }

  def self.points
    PointsService.total_points(slack_user_name)
  end

  def self.reasons
    PointsService.reasons_report(slack_user_name)
  end
end
