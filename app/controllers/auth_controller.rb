# code is heavily borrowed from https://github.com/slackapi/Slack-Ruby-Onboarding-Tutorial/blob/master/auth.rb
class AuthController < ApplicationController

  BOT_SCOPE = 'bot'

  SLACK_CONFIG = {
    slack_client_id: ENV['SLACK_CLIENT_ID'],
    slack_api_secret: ENV['SLACK_API_SECRET'],
    slack_redirect_uri: ENV['SLACK_REDIRECT_URI'],
    slack_verification_token: ENV['SLACK_VERIFICATION_TOKEN']
  }.freeze

  def begin
    render html: add_to_slack_button
  end

  def finish
    client = Slack::Web::Client.new
    # OAuth Step 3: Success or failure
    begin
      response = client.oauth_access(
        {
            client_id: SLACK_CONFIG[:slack_client_id],
            client_secret: SLACK_CONFIG[:slack_api_secret],
            redirect_uri: SLACK_CONFIG[:slack_redirect_uri],
            code: params[:code] # (This is the OAuth code mentioned above)
        }
      )
      # Success:
      # Yay! Auth succeeded! Let's store the tokens and create a Slack client to use in our Events handlers.
      # The tokens we receive are used for accessing the Web API, but this process also creates the Team's bot user and
      # authorizes the app to access the Team's Events.
      team_id = response['team_id']
      store_team_auth(response, team_id)

      # Be sure to let the user know that auth succeeded.
      render text: "Yay! Auth succeeded! You're awesome!"
    rescue Slack::Web::Api::Error => e
      # Failure:
      # D'oh! Let the user know that something went wrong and output the error message returned by the Slack client.
      render plain: "Auth failed! Reason: #{e.message}<br/>#{add_to_slack_button}", status: 403
    end
  end

  private

  def add_to_slack_button
    """
    <a href=\"https://slack.com/oauth/authorize?scope=#{BOT_SCOPE}&client_id=#{SLACK_CONFIG[:slack_client_id]}&redirect_uri=#{SLACK_CONFIG[:slack_redirect_uri]}\">
      <img alt=\"Add to Slack\" height=\"40\" width=\"139\" src=\"https://platform.slack-edge.com/img/add_to_slack.png\"/>
    </a>
    """.html_safe
  end

  def create_slack_client(slack_api_secret)
    Slack.configure do |config|
      config.token = slack_api_secret
      fail 'Missing API token' unless config.token
    end
    Slack::Web::Client.new
  end

  def store_team_auth(response, team_id)
    SlackTeam.create!(
      teamid: team_id,
      oauth_access_token: response['access_token'],
      bot_userid: response['bot']['bot_user_id'],
      bot_oauth_access_token: response['bot']['bot_access_token']
    )
  end
end
