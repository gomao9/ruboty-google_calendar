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
          client = Ruboty::GoogleCalendar::CalendarClient.new ENV
          client.search('primary').map(&:summary).join("\n")
        end

      end
    end
  end
end
