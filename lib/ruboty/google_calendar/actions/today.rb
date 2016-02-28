require 'ruboty'
module Ruboty
  module GoogleCalendar
    module Actions
      class Today < Ruboty::Actions::Base
        def call
          message.reply(today)
        rescue => e
          message.reply(e.message + "\n" + e.backtrace.join("\n"))
        end

        private

        def today
          day = if message[:date]
                  year, month, day = message[:date].scan(/(\d{4})(\d{2})(\d{2})/).first
                  Time.new(year, month, day)
                else
                  Time.now
                end

          ids = ENV['GOOGLE_CALENDAR_IDS'].split(',')
          client = Ruboty::GoogleCalendar::CalendarClient.new ENV
          ids.flat_map{|id| client.search(id, day)}.uniq(&:id).map do |event|
            event.summary
          end.join("\n")
        end

      end
    end
  end
end
