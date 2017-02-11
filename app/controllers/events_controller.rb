class EventsController < ApplicationController
  before_action :verify_slack_token

  def new
    case params.dig(:event, :type)
      when 'url_verification'
        # Echo back challenge param
        # called during bot activation for Slack server to verify bot URL.
        render text: params[:challenge]
      when 'message'
        MessageEventHandler.new(params).handle(params)
      when 'reaction_added'
        ReactionAddedEventHandler.new(params).handle(params)
    end
  end

  private

  def verify_slack_token
    raise 'Slack token invalid' unless params[:token] == ENV['SLACK_VERIFICATION_TOKEN']
  end
end
