class RecognitionsService
  def self.create_recognition(teamid, channel, subject, vote_string, reason, voterid, ts, first_vote)
    direction = vote_direction(vote_string)
    point = direction ? Vote::UP : Vote::DOWN
    is_user_subject = (SlackUserFormatter.unescape(subject)) == subject ? false : true
    recognition = Recognition.create!(
      channel: channel,
      subject: SlackUserFormatter.unescape(subject),
      teamid: teamid,
      text: reason,
      ts: ts,
      user_subject: is_user_subject,
      vote_direction: direction
    )
    unescaped_voterid = SlackUserFormatter.unescape(voterid)
    voter = SlackUser.find_or_create_by!(teamid: teamid, slack_userid: unescaped_voterid)
    recognition.votes << Vote.new(teamid: teamid, slack_user: voter, point: point, first_vote: first_vote)
    recognition.save!
    recognition
  end

  def self.vote(teamid, recognition, voterid, emoji, first_vote = false, flip_vote_direction = false)
    direction = recognition.vote_direction ^ flip_vote_direction
    point = direction ? Vote::UP : Vote::DOWN
    unescaped_voterid = SlackUserFormatter.unescape(voterid)
    voter = SlackUser.find_or_create_by!(teamid: teamid, slack_userid: unescaped_voterid)
    recognition.votes << Vote.new(teamid: teamid, slack_user: voter, emoji: emoji, point: point, first_vote: first_vote)
    recognition.save!
  end

  private

  UPVOTE_EMOJI_STRINGS = %w(:thumbsup: :heavy_plus_sign:).freeze
  DOWNVOTE_EMOJI_STRINGS = %w(:thumbsdown: :heavy_minus_sign:).freeze

  def self.vote_direction(vote_string)
    if vote_string.start_with?('++') || vote_string.in?(UPVOTE_EMOJI_STRINGS)
      true
    elsif vote_string.start_with?('--') || vote_string.in?(DOWNVOTE_EMOJI_STRINGS)
      false
    end
  end
end