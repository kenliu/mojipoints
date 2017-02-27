class ReactionAddedEventHandler < BaseEventHandler
  def handle(params)
    user_id = params[:event][:user]
    return if bot_user?(user_id)

    msg = params[:event][:item][:ts]
    channel = params[:event][:item][:channel]
    voterid = user_id
    emoji = params[:event][:reaction]

    recognition = Recognition.find_by(bot_msg_ts: msg) || # case where reaction was on the bot message
                  Recognition.find_by(ts: msg) # case where reaction was on the original recognition message
    unless recognition
      Rails.logger.debug "recognition for message: #{msg} not found"
      return
    end

    if SelfRecognitionCheck.self_recognition?(voterid, recognition.subject)
      # do nothing for now
      # in the future we will chastise the user for self voting
      Rails.logger.info("#{voterid} tried to self-vote")
    else
      RecognitionsService.vote(team_id, recognition, voterid, emoji, false)

      attachment = ScoreMessageFormatter.format_slack_message(recognition)

      slack_api.chat_update(
        ts: recognition.bot_msg_ts,
        as_user: 'true',
        channel: channel,
        attachments: [attachment]
      )
    end
  end
end