module Commands
  class ScoreCommand < BaseCommand

    def match(channel:, message:)
      @message = direct_message(message, channel)
      @message&.start_with?('score ')
    end

    def response(params:)
      @message =~ /score (.*)/
      subject = $1
      data = PointsService.reasons_report(subject)
      total = PointsService.total_points(subject)

      reasons = data.map { |reason, count| "#{reason}: #{count} points" }.join("\n")
      report = "#{subject} has #{total} points. Here are some reasons: \n" + reasons
      { text: report }
    end

  end
end
