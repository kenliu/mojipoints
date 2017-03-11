class MessageEventHandler < BaseEventHandler
  def handle(params)
    # Don't process messages sent from our bot user
    user_id = params[:event][:user]
    return if bot_user?(user_id)
    return if params[:event][:subtype] # don't handle anything besides a normal message

    message = params[:event][:text]
    message = params[:event][:message][:text] unless message # message events can come in with two different structures

    recognition_command = Commands::RecognitionCommand.new(params)
    source_channel = params[:event][:channel]
    if recognition_command.match(message: message)
      command_response = recognition_command.response(message: message, params: params)

      # if there was a response message
      if command_response
        api_response = slack_api.chat_postMessage(
          as_user: 'true',
          channel: command_response[:channel],
          text: command_response[:text]
        )
        Rails.logger.info("posted bot message #{api_response[:ts]}")
        recognition_command.after_response(params, api_response)
      end
    elsif Commands::TopCommand.new(bot_user: bot_user).match(channel: source_channel, message: message)
      slack_api.chat_postMessage(
        as_user: 'true',
        channel: dm_channel(team_id, user_id),
        text: Commands::TopCommand.new(bot_user: bot_user).response(params: params)[:text]
      )
    elsif Commands::HelpCommand.new(bot_user: bot_user).match(channel: source_channel, message: message)
      slack_api.chat_postMessage(
        as_user: 'true',
        channel: source_channel,
        text: Commands::HelpCommand.new(bot_user: bot_user).response(params: params)[:text]
      )
    elsif Commands::ScoreCommand.new(bot_user: bot_user).match(channel: source_channel, message: message)
      # FIXME this is ugly
      command = Commands::ScoreCommand.new(bot_user: bot_user)
      command.match(channel: source_channel, message: message)
      slack_api.chat_postMessage(
        as_user: 'true',
        channel: source_channel,
        # FIXME this blows up if there is no data in the DB
        text: command.response(params: params)[:text]
      )
    elsif Commands::PlusPlusCommand.new(bot_user: bot_user).match(channel: source_channel, message: message)
      slack_api.chat_postMessage(
          as_user: 'true',
          channel: dm_channel(team_id, user_id),
          text: Commands::PlusPlusCommand.new(bot_user: bot_user).response(params: params)[:text]
      )
      Keen.publish(:plusplus, { user_id: user_id })
    end
  end

  private

  def dm_channel(team_id, user_id)
    SlackMessagingService.im_channel(team_id, user_id)
  end
end