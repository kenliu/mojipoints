class ScoreMessageFormatter
  def self.format_slack_message(recognition)
    reason = recognition.text
    subject = recognition.subject

    message = subject_has_total_points(subject)
    attachment = {
      fallback: message,
      title: message,
      # TODO not sure if this should include all voters for all time
      footer: "#{voters(recognition)}"
    }

    attachment['text'] = points_for_reason(subject, reason) if reason
    attachment
  end

  def self.points_for_reason(subject, reason)
    # TODO deal with pluralization
    "#{PointsService.points_for_reason(subject, reason).to_s} of which are for #{reason}"
  end

  def self.subject_has_total_points(subject)
    # TODO deal with pluralization
    "#{subject} has #{PointsService.total_points(subject)} points"
  end

  def self.voters(recognition)
    # TODO this will cause users to get DMed, not sure if this will
    # be super annoying or not. might want to format user names directly
    direction_emoji = recognition.vote_direction ? ':thumbsup:' : ':thumbsdown:'
    "#{direction_emoji} by " +
    recognition.votes.collect { |vote| vote.slack_user }
      .uniq
      .collect {|slack_user| "<@#{slack_user.slack_userid}>" }
      .join(', ')
  end
end