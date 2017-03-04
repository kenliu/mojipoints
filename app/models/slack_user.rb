class SlackUser < ApplicationRecord
  USERID_REGEX = /\AU\w+\z/
  ESCAPED_USERID_REGEX = /\A<@(U\w+)>\z/

  has_many :votes

  validates :slack_userid, presence: true
  validates :slack_userid, format: { with: SlackUser::USERID_REGEX, message: 'in wrong format' }

  def to_slack_api
    SlackUserFormatter.format(slack_userid)
  end

  def self.escaped_slack_userid?(text)
    ESCAPED_USERID_REGEX.match(text)
  end

  def self.points
    PointsService.total_points(slack_user_name)
  end

  def self.reasons
    PointsService.reasons_report(slack_user_name)
  end
end
