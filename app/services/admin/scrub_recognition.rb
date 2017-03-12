module Admin
  class ScrubRecognition
    def initialize(teamid, subject)
      @teamid = teamid
      @subject = subject
    end

    def execute
      subject = SlackUserFormatter.unescape(@subject)
      recognitions = Recognition.where(teamid: @teamid, subject: subject)
      recognitions.each(&:destroy!)
    end
  end
end