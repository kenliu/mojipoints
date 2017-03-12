module Commands
  class ScrubCommand < BaseCommand
    def match(channel:, message:)
      direct_message(message, channel)&.start_with?('scrub ')
    end

    def response(params:, message:)
      text = message.split('scrub ').last
      deleted = ::Admin::ScrubRecognition.new(teamid, text).execute
      Rails.logger.info("scrubbed #{deleted}")
      { text: "scrubbed `#{text}`" }
    end
  end
end