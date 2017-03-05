module Commands
  class TopCommand < BaseCommand
    def match(channel:, message:)
      direct_message(message, channel)&.start_with?('top')
    end

    def response(params:)

      text = PointsService.top_recognitions_report
                 .map { |subject, score| format_line(subject, score) }
                 .join("\n")

      {
        text: text
      }
    end

    private

    def format_line(subject, score)
      # issue #92
      # This is a hacky way of formatting users; if a subject happens to match string format
      # then it gets formatted as a user when rendering score
      subject = SlackUserFormatter.valid_userid?(subject) ? SlackUserFormatter.format(subject) : subject
      "#{score} points: #{subject}"
    end
  end
end