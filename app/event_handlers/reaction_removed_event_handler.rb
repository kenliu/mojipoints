class ReactionRemovedEventHandler < BaseEventHandler

  def handle(params)
    user_id = params[:event][:user]
    msg = params[:event][:item][:ts]
    channel = params[:event][:item][:channel]
    emoji = params[:event][:reaction]
    voterid = user_id

    recognition = Recognition.find_by(bot_msg_ts: msg) || # case where reaction was on the bot message
                  Recognition.find_by(ts: msg) # case where reaction was on the original recognition message

    unless recognition
      Rails.logger.debug "recognition for message: #{msg} not found"
      return
    end

    RecognitionsService.vote(team_id, recognition, voterid, emoji, false, true)

    attachment = ScoreMessageFormatter.format_slack_message(recognition)

    slack_api.chat_update(
      ts: recognition.bot_msg_ts,
      as_user: 'true',
      channel: channel,
      attachments: [attachment]
    )
  end
end