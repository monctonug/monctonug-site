Dotenv.load

require_relative "lib/eventbrite"

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate  :directory_indexes
proxy "/feed/", "feed.xml"

Eventbrite::API.new.get_events.each do |event|
  proxy "/event/#{event.id}", "event.html", locals: { event: event }
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  activate :relative_assets
end

helpers do
  def event_list
    return Eventbrite::API.new.get_events
  end
end
