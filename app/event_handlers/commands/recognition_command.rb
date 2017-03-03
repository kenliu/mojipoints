module Commands
  class RecognitionCommand
    attr_reader :subject, :vote_string, :reason, :team_id

    # TODO DRY the vote strings with the recognition service class
    EMOJI_STRINGS = %w(:thumbsup: :heavy_plus_sign: :thumbsdown: :heavy_minus_sign:).freeze

    def initialize(params)
      @team_id = params[:team_id]
    end

    def match(message:)
      match_data = /^([\s\w'@.:\u3040-\u30FF\uFF01-\uFF60\u4E00-\u9FA0<>]+)\s*(\+{2}|-{2}|#{EMOJI_STRINGS.join('|')})( for (.+$))?$/.match(message)
      if match_data
        @subject = match_data[1].strip if match_data[1]
        @vote_string = match_data[2]
        @reason = match_data[4]
      end
      match_data
    end

    def response(message:, params:)
      channel = params[:event][:channel]
      voterid = params[:event][:user]
      ts = params[:event][:ts]

      if SelfRecognitionCheck.self_recognition?(voterid, @subject)
        @self_recognition = true
        # do nothing for now
        # in the future we will chastise the user for self voting
        Rails.logger.info("#{voterid} tried to self-vote")
        nil
      else
        @self_recognition = false
        @recognition = RecognitionsService.create_recognition(
          team_id,
          channel,
          @subject,
          @vote_string,
          @reason,
          voterid,
          ts,
          true
        )
        attachment = ScoreMessageFormatter.format_slack_message(@recognition)
        {
          attachments: [attachment],
          channel: channel
        }
      end
    end

    def after_response(_, api_response)
      @recognition.update(bot_msg_ts: api_response[:ts]) unless @self_recognition
    end
  end
end