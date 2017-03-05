module Admin
  class PurgeAllUserData
    def initialize(teamid)
      @teamid = teamid
    end

    def execute
      Rails.logger.info("Started deleting all users for team: #{@teamid}")
      SlackUser.delete_all
      Rails.logger.info("Completed deleting all users for team: #{@teamid}")
    end
  end
end