module Eventbrite

  class Event

    def initialize(json)
      @json = json
    end

    def id
      @json["id"]
    end

    def name
      @json["name"]["text"]
    end

    def description
      @json["description"]["html"]
    end

    def url
      @json["url"]
    end

    def live?
      @json["status"] == "live"
    end

    def created_at
      Time.parse(@json["created"])
    end

    def updated_at
      Time.parse(@json["changed"])
    end

    # Monday, 30 November 2015 from 7:00 PM to 10:00 PM (AST)
    def formatted_time
      [
        start_time.strftime("%A, %e %B %Y"),
        "from",
        start_time.strftime("%l:%M %p"),
        "to",
        end_time.strftime("%l:%M %p"),
        "(#{timezone})"
      ].join(" ")
    end

    def timezone
      @json["start"]["timezone"]
    end

    def start_time
      Time.parse(@json["start"]["local"])
    end

    def end_time
      Time.parse(@json["end"]["local"])
    end
  end

end
