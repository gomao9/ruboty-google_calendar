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
          "today"
        end

      end
    end
  end
end
