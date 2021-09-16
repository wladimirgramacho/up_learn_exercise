require 'open-uri'
require 'nokogiri'
require 'ostruct'


def fetch(url)
  html = Nokogiri::HTML(URI.open(url))
  result = OpenStruct.new

  result.success = true
  result.links = html.css('a').map { |anchor_tag| anchor_tag['href'] }.filter { |link| valid_url?(link) }
  result.assets = html.css('img').map { |image_tag| image_tag['src'] }.filter { |link| valid_url?(link) }

  result
end

def valid_url?(url)
  url.start_with?('http') && url =~ URI::regexp
end