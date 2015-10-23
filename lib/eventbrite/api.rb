module Eventbrite
  class API

    def get_current_user
      request("users/me")
    end

    def get_events
      response = request("users/me/owned_events?status=live,started,ended")
      response["events"].map do |event|
        Event.new(event)
      end.sort_by do |event|
        event.start_time
      end.reverse
    end

    private

    def request(endpoint)
      response = RestClient.get("#{root_url}/#{endpoint}", headers)
      return JSON.parse(response.body)
    end

    def root_url
      "https://www.eventbriteapi.com/v3"
    end

    def headers
      {
        :accept        => :json,
        :content_type  => :json,
        :Authorization => "Bearer #{token}"
      }
    end

    def token
      ENV["EVENTBRITE_OAUTH_TOKEN"]
    end
  end
end
