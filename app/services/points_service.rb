class PointsService

  DEFAULT_TOP_RECOGNITIONS = 100

  def self.total_points(subject)
    Recognition.where(subject: subject).joins(:votes).sum('votes.point')
  end

  def self.points_for_reason(subject, reason)
    Recognition.where(subject: subject, text: reason).joins(:votes).sum('votes.point')
  end

  def self.reasons_report(subject)
    Recognition.where(subject: subject).joins(:votes)
        .group('recognitions.text')
        .order('sum_votes_point desc')
        .sum('votes.point')
  end

  def self.top_recognitions_report(limit = DEFAULT_TOP_RECOGNITIONS)
    Recognition.joins(:votes)
        .group('recognitions.subject')
        .order('sum_votes_point desc')
        .limit(limit)
        .sum('votes.point')
  end
end