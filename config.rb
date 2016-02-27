Dotenv.load

require_relative "lib/eventbrite"

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :blog do |blog|
  blog.sources = "articles/{year}-{month}-{day}-{fname}.html"
  blog.permalink = "{year}/{month}/{day}/{title}"
  blog.default_extension = ".md"
  blog.layout = "layouts/article_layout"
  blog.publish_future_dated = true
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
