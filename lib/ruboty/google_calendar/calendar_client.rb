require "json"
require 'google/api_client'
require 'active_support'
require 'active_support/core_ext/time'
module Ruboty
  module GoogleCalendar
    class CalendarClient
      APPLICATION_NAME = 'ruboty-google_calendar'

      def initialize(env)
        # Initialize OAuth 2.0 client
        # authorization
        @client = Google::APIClient.new(application_name: APPLICATION_NAME)
        @client.authorization.client_id = env["GOOGLE_CALENDAR_CLIENT_ID"]
        @client.authorization.client_secret = env["GOOGLE_CALENDAR_CLIENT_SECRET"]
        @client.authorization.scope = env["GOOGLE_CALENDAR_SCOPE"]
        @client.authorization.refresh_token = env["GOOGLE_CALENDAR_REFRESH_TOKEN"]
        @client.authorization.access_token = env["GOOGLE_CALENDAR_ACCESS_TOKEN"]

        @cal = @client.discovered_api('calendar', 'v3')
      end


      def search id, day=Time.now
        # 時間を格納
        min = day.beginning_of_day.iso8601
        max = day.end_of_day.iso8601

        # イベントの取得
        params = {'calendarId' => id,
                  'orderBy' => 'startTime',
                  'timeMin' => min,
                  'timeMax' => max,
                  'singleEvents' => 'True'}

        result = @client.execute(:api_method => @cal.events.list,
                                 :parameters => params)
        # 結果を返却
        result.data.items
      end
    end

  end

end
