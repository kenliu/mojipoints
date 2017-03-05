require 'thor/rails'

class Admin < Thor
  include Thor::Rails

  desc 'nuke_team_data', 'clears all the data for an entire team'
  def nuke_team_data
    # TODO prompt for team id
    teamid = nil
    service = ::Admin::PurgeAllRecognitions.new(teamid)
    service.execute
    service = ::Admin::PurgeAllUserData.new(teamid)
    service.execute
  end
end