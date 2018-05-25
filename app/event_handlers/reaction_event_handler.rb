# Base class for handling reaction events.
class ReactionEventHandler < BaseEventHandler
  def post_recognition(channel, emoji, recognition, voterid, first_vote, flip_vote_direction)
    RecognitionsService.vote(team_id, recognition, voterid, emoji, first_vote, flip_vote_direction)

    attachment = ScoreMessageFormatter.format_slack_message(recognition)

    slack_api.chat_update(
      ts: recognition.bot_msg_ts,
      as_user: 'true',
      channel: channel,
      attachments: [attachment]
    )
  end
end
