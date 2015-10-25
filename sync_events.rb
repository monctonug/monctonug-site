require "rubygems"
require "bundler"
require "yaml"

require_relative "lib/eventbrite"

Bundler.require
Dotenv.load

def article_source_path_for(event)
  d = event.created_at
  "source/articles/#{d.year}-#{d.month}-#{d.day}-#{event.id}.html.erb"
end


Eventbrite::API.new.get_events.each do |event|
  path = article_source_path_for(event)

  frontmatter = { }

  if File.exist?(path)
    frontmatter = YAML.load( IO.read(path) )
  end

  frontmatter.merge!({
                       "title" => event.name,
                       "date" => event.created_at.strftime("%Y-%m-%d %H:%M UTC"),
                       "eventbrite" => event.blob
                     })

  File.open(path, "w") do |f|
    f.puts frontmatter.to_yaml
    f.puts "---"
  end
end
