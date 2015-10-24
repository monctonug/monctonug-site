---
layout: false
index_file: "index.xml"
---

xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title data.strings.title
  xml.subtitle ""
  xml.id data.strings.site_url
  xml.link "href" => data.strings.site_url
  xml.link "href" => data.strings.site_url, "rel" => "self"
  xml.updated(event_list.first.updated_at.iso8601) unless event_list.empty?
  xml.author { xml.name data.strings.title }

  event_list.each do |event|
    xml.entry do
      xml.title event.name
      xml.link "rel" => "alternate", "href" => URI.join(data.strings.site_url, "event/#{event.id}")
      xml.id data.strings.site_url
      xml.published event.created_at.iso8601
      xml.updated event.updated_at.iso8601
      xml.author { xml.name data.strings.title }
      xml.content partial("event", locals: { event: event, skip_title: true }), "type" => "html"
    end
  end
end
