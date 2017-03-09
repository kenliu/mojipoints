require 'thor/rails'

class Admin < Thor
  include Thor::Rails
  include Thor::Actions

  desc 'nuke_team_data', 'clears all the data for an entire team'
  def nuke_team_data
    # TODO prompt for team id
    teamid = nil
    service = ::Admin::PurgeAllRecognitions.new(teamid)
    service.execute
    service = ::Admin::PurgeAllUserData.new(teamid)
    service.execute
  end

  option :date, required: true
  desc 'scrub_day_data', 'clears all the recognitions, votes for a given day'
  def scrub_day_data
    # TODO prompt for team id
    teamid = nil
    service = ::Admin::ScrubAllRecognitions.new(teamid)
    tz = 'Eastern Time (US & Canada)'
    date = options[:date]
    recognitions = service.query(tz, date)
    puts "deleting recognitions:"
    puts format_records_to_delete(recognitions)
    puts
    if yes?("do you want to delete these?")
      deleted = service.delete(tz, date)
      puts "deleted #{deleted.size} recognitions"
    else
      puts 'bailing!'
    end
  end

  private

  def format_records_to_delete(recognitions)
    recognitions.map do |r|
      "#{r.subject} for #{r.reason}: #{r.votes.count} votes"
    end.join("\n")
  end
end