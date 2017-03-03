module Commands
  class TopCommand < BaseCommand

    def match(channel:, message:)
      direct_message(message, channel)&.start_with?('top')
    end

    def response(params:)
      {
        text: PointsService.top_recognitions_report.map { |subject, score| "#{score} points: #{subject}" }.join("\n")
      }
    end
  end
end