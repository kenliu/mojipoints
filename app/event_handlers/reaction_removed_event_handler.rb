# Handles all Slack "reaction_removed" events.
#
# removing a reaction decrements the score for a subject.
class ReactionRemovedEventHandler < ReactionEventHandler
  def handle(params)
    user_id = params[:event][:user]
    return if bot_user?(user_id)

    channel = params[:event][:item][:channel]
    voterid = user_id
    emoji = params[:event][:reaction]

    msg = params[:event][:item][:ts]

    return unless msg
    recognition = Recognition.find_by(bot_msg_ts: msg) || # case where reaction was on the bot message
                  Recognition.find_by(ts: msg) # case where reaction was on the original recognition message
    unless recognition
      Rails.logger.debug "recognition for message: #{msg} not found"
      return
    end

    if voterid == recognition.subject
      # do nothing for now
      # in the future we will chastise the user for self voting
      Rails.logger.info("#{voterid} tried to self-vote")
    else
      post_recognition(channel, emoji, recognition, voterid, false, true)
    end
  end
end