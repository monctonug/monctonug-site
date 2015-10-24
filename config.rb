Dotenv.load

require_relative "lib/eventbrite"

def article_source_path_for(event)
  d = event.created_at
  "source/articles/#{d.year}-#{d.month}-#{d.day}-#{event.id}.html.erb"
end

def sync_events
  Eventbrite::API.new.get_events.each do |event|
    frontmatter = {
      "title" => event.name,
      "date" => event.created_at.strftime("%Y-%m-%d %H:%M UTC"),
      "eventbrite" => event.blob
    }

    File.open(article_source_path_for(event), "w") do |f|
      f.puts frontmatter.to_yaml
      f.puts "---"
    end
  end
end


sync_events

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :blog do |blog|
  blog.sources = "articles/{year}-{month}-{day}-{fname}.html"
  blog.permalink = "{year}/{month}/{day}/{title}"
  blog.default_extension = ".md"
  blog.layout = "layouts/article_layout"
end

activate  :directory_indexes
proxy "/feed/", "feed.xml"

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end

helpers do
  def event_for(article)
    if article.data.eventbrite
      Eventbrite::Event.new(article.data.eventbrite)
    else
      nil
    end
  end
end
