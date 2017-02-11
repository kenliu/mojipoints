class SlackTeam < ApplicationRecord
  validates :teamid, presence: true, uniqueness: true
  validates :bot_userid, :bot_oauth_access_token, :oauth_access_token, presence: true
end
