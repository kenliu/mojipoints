class RecognitionsService
  def self.create_recognition(teamid, channel, subject, vote_string, reason, voterid, ts, first_vote)
    point = vote_string.start_with?('++') ? Vote::UP : Vote::DOWN
    vote_direction = point > 0 ? true : false
    recognition = Recognition.create!(teamid: teamid, channel: channel, text: reason, subject: subject, ts: ts, vote_direction: vote_direction)
    voter = SlackUser.find_or_create_by(teamid: teamid, slack_userid: voterid)
    recognition.votes << Vote.new(teamid: teamid, slack_user: voter, point: point, first_vote: first_vote)
    recognition.save!
    recognition
  end

  def self.vote(teamid, recognition, voterid, emoji, first_vote = false)
    point = recognition.vote_direction ? Vote::UP : Vote::DOWN
    voter = SlackUser.find_or_create_by(teamid: teamid, slack_userid: voterid)
    recognition.votes << Vote.new(teamid: teamid, slack_user: voter, emoji: emoji, point: point, first_vote: first_vote)
    recognition.save!
  end
end