class BaseEventHandler

  attr_reader :team_id

  def initialize(params, slack_api = nil)
    @team_id = params[:team_id]
    @params = params
    @slack_api = slack_api if slack_api
  end

  def bot_user? user
    user == bot_user
  end

  def create_slack_client(teamid)
    team = SlackTeam.find_by(teamid: teamid)
    Slack.configure do |config|
      config.token = team.bot_oauth_access_token
      fail 'Missing API token' unless config.token
    end
    Slack::Web::Client.new
  end

  def voters_message(recognition)
    recognition.votes.collect {|vote| vote.slack_user}
        .uniq
        .collect {|slack_user| "<@#{slack_user.slack_userid}>" }
        .join(', ')
  end

  def slack_api
    @slack_api ||= create_slack_client(team_id)
  end

  def bot_user
    SlackTeam.find_by(teamid: team_id).bot_userid
  end
end