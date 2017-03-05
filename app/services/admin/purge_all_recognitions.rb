module Admin
  class PurgeAllRecognitions
    def initialize(teamid)
      @teamid = teamid
    end

    def execute
      Rails.logger.info("Started deleting all recognitions and votes for team: #{@teamid}")
      Recognition.delete_all
      Rails.logger.info("Completed deleting all recognitions and votes for team: #{@teamid}")
    end
  end
end