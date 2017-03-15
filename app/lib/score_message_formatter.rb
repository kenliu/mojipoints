class ScoreMessageFormatter
  def self.format_slack_message(recognition)
    reason = recognition.text
    subject = recognition.subject

    message = recognition.user_subject ? user_has_total_points(subject) : subject_has_total_points(subject)
    attachment = {
      fallback: message,
      title: message,
      # TODO not sure if this should include all voters for all time
      footer: "#{voters(recognition)}"
    }

    attachment[:text] = points_for_reason(subject, reason) if reason
    attachment
  end

  def self.points_for_reason(subject, reason)
    "#{PointsService.points_for_reason(subject, reason)} of which are for #{reason}"
  end

  def self.user_has_total_points(subject)
    total_points = PointsService.total_points(subject)
    points_string = 'point'.pluralize(total_points)
    "#{SlackUserFormatter.format(subject)} has #{total_points} #{points_string}"
  end

  def self.subject_has_total_points(subject)
    total_points = PointsService.total_points(subject)
    points_string = 'point'.pluralize(total_points)
    "#{subject} has #{total_points} #{points_string}"
  end

  def self.voters(recognition)
    # TODO this will cause users to get DMed, not sure if this will
    # be super annoying or not. might want to format user names directly
    direction_emoji = recognition.vote_direction ? ':thumbsup:' : ':thumbsdown:'
    "#{direction_emoji} by " +
    recognition.votes
      .collect { |vote| vote.slack_user }
      .uniq
      .collect { |slack_user| "#{slack_user.to_slack_api}" }
      .join(', ')
  end
end