require 'ruboty'
module Ruboty
  module GoogleCalendar
    module Actions
      class Today < Ruboty::Actions::Base
        def call
          message.reply(today)
        rescue => e
          message.reply(e.message)
        end

        private

        def today
          ids = ENV['GOOGLE_CALENDAR_IDS'].split(',')
          client = Ruboty::GoogleCalendar::CalendarClient.new ENV
          ids.flat_map{|id| client.search(id)}.map(&:summary).join("\n")
        end

      end
    end
  end
end
