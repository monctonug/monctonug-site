module Eventbrite
  class API

    def get_current_user
      request("users/me")
    end

    def get_events
      response = request("users/me/owned_events?status=live,started,ended&order_by=start_asc")
      response["events"].map do |event|
        Event.new(event)
      end
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
