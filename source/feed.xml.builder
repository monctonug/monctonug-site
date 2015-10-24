---
layout: false
---

xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title data.strings.title
  xml.subtitle ""
  xml.id data.strings.site_url
  xml.link "href" => URI.join(data.strings.site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(data.strings.site_url, current_page.path), "rel" => "self"
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name data.strings.title }

  blog.articles[0..10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(data.strings.site_url, article.url)
      xml.id URI.join(data.strings.site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name data.strings.title }
      xml.content partial("layouts/article", locals: { article: article, skip_title: true }), "type" => "html"
    end
  end
end
