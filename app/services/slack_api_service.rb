class SlackApiService
  def self.create_slack_client(teamid)
    team = SlackTeam.find_by(teamid: teamid)
    Slack.configure do |config|
      config.token = team.bot_oauth_access_token
      fail 'Missing API token' unless config.token
    end
    Slack::Web::Client.new
  end
end