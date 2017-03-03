class ReactionRemovedEventHandler < ReactionEventHandler

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

    post_recognition(channel, emoji, recognition, voterid, false, true)
  end
end