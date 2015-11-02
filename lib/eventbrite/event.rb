module Eventbrite

  class Event

    attr_reader :blob

    def initialize(blob)
      @blob = blob
    end

    def id
      @blob["id"]
    end

    def name
      @blob["name"]["text"]
    end

    def description
      desc = @blob["description"]["html"]

      doc = Nokogiri::HTML.fragment(desc)

      doc.css("p > br").remove

      doc.css("*").remove_attr("style")

      doc.css("font").each do |node|
        node.attributes.keys.each do |attr|
          node.remove_attribute(attr)
        end
      end

      doc.to_html
    end

    def url
      @blob["url"]
    end

    def live?
      @blob["status"] == "live"
    end

    def created_at
      Time.parse(@blob["created"])
    end

    def updated_at
      Time.parse(@blob["changed"])
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
      @blob["start"]["timezone"]
    end

    def start_time
      Time.parse(@blob["start"]["local"])
    end

    def end_time
      Time.parse(@blob["end"]["local"])
    end

    def to_blob
      @blob.to_json
    end

  end

end
