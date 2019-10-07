require "json"
require "uri"

module Eventbrite
  class API

    def get_current_user
      request("users/me")
    end

    def get_events
      events = [ ]
      page = page_count = 1

      while page <= page_count
        response = request("users/me/owned_events?page=#{page}&status=live,started,ended")
        events += response["events"].map do |raw|
          event = Event.new(raw)

          # Fetch description from new API for newer events that use separate APIs
          if event.name.downcase == event.description.downcase
            content = request("events/#{event.id}/structured_content")
            event.description = content["modules"][0]["data"]["body"]["text"]
          end

          event
        end

        page += 1
        page_count = response["pagination"]["page_count"]
      end

      return events.sort_by do |event|
        event.start_time
      end.reverse
    end

    private

    def request(endpoint)
      url = URI.join(root_url, endpoint).to_s
      response = RestClient.get(url, headers)
      return JSON.parse(response.body)
    end

    def root_url
      "https://www.eventbriteapi.com/v3/"
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
