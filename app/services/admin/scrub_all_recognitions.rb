module Admin
  class ScrubAllRecognitions

    def initialize(teamid)
      @teamid = teamid
    end

    def query(tz, date)
      recognitions(date, tz)
    end

    def delete(tz, date)
      recognitions(date, tz).destroy_all
    end

    private

    def recognitions(date, tz)
      Time.zone = tz
      start_time = Time.zone.parse(date).beginning_of_day
      end_time = Time.zone.parse(date).end_of_day
      Recognition.where(
          'created_at between :start_time and :end_time',
          start_time: start_time,
          end_time: end_time
      )
    end
  end
end