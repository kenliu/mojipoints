class PointsService
  def self.total_points(subject)
    Recognition.where(subject: subject).joins(:votes).sum('votes.point')
  end

  def self.points_for_reason(subject, reason)
    Recognition.where(subject: subject, text: reason).joins(:votes).sum('votes.point')
  end

  def self.reasons_report(subject)
    Recognition.where(subject: subject).joins(:votes).group('recognitions.text').order('votes.point desc').sum('votes.point')
  end

  def self.top_users_report
    Recognition.joins(:votes).group('recognitions.subject').order('sum(votes.point) desc').sum('votes.point')
  end
end