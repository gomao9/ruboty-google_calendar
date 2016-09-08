require 'json'
require 'ruboty'
module Ruboty::GoogleCalendar::Actions
  class Today < Ruboty::Actions::Base
    HHMM_FORMAT = "%H:%M"
    ALLDAY      = "終日"
    NO_SCHEDULE = "今日の予定はありません"
    def call
      message.reply(today)
    rescue => e
      message.reply(e.message + "\n" + e.backtrace.join("\n"))
    end

    private

    def today
      day = if message[:date].present?
              year, month, day = message[:date].scan(/(\d{4})(\d{2})(\d{2})/).first
              Time.new(year, month, day)
            else
              Time.now
            end

      ids = JSON.parse(ENV['GOOGLE_CALENDAR_IDS'])
      client = Ruboty::GoogleCalendar::CalendarClient.new ENV
      events = ids.keys.flat_map{|id| client.search(id, day).map{|event| [id, event]}}

      text = events.sort_by{|_, event| [event.start.date_time.to_i, event.end.date_time.to_i] }.group_by{|_, event| event.id}.map do |id, events|
        event = events.first[1]
        time = if event.start.date_time
                 time_format(event.start.date_time, event.end.date_time)
               else
                 ALLDAY
               end
        atendees = events.map{|id, _| ids[id]}.join(',')

        sprintf("%s[%s]:%s", time, atendees, event.summary)
      end.join("\n")

      text.empty? ? NO_SCHEDULE : text
    end

    def time_format st, ed
      "#{st.strftime(HHMM_FORMAT)}〜#{ed.strftime(HHMM_FORMAT)}"
    end

  end
end
