require "ruboty/google_calendar/actions/today"
require "ruboty/google_calendar/calendar_client"

module Ruboty
  module Handlers
    # Replies events in GoogleCalendar
    class GoogleCalendar < Base
      on /今日の予定\z/, name: 'today', description: "Replies today's events"
      env :GOOGLE_CALENDAR_CLIENT_ID, "client id"
      env :GOOGLE_CALENDAR_CLIENT_SECRET, "client secret"
      env :GOOGLE_CALENDAR_SCOPE, "scope"
      env :GOOGLE_CALENDAR_REFRESH_TOKEN, "refresh token"
      env :GOOGLE_CALENDAR_ACCESS_TOKEN, "access token"

      def today(message)
        Ruboty::GoogleCalendar::Actions::Today.new(message).call
      end

    end
  end
end
