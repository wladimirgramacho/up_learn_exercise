require 'open-uri'
require 'nokogiri'
require 'ostruct'


def fetch(url)
  return OpenStruct.new(success: false, error: 'Invalid URL') unless valid_url?(url)

  result = OpenStruct.new

  html = Nokogiri::HTML(URI.open(url))

  result.success = true
  result.links = html.css('a').map { |anchor_tag| anchor_tag['href'] }.filter { |link| valid_url?(link) }
  result.assets = html.css('img').map { |image_tag| image_tag['src'] }.filter { |link| valid_url?(link) }

  result
rescue StandardError => error
  result.success = false
  result.error = "Couldn't fetch the url. Error: #{error.inspect}"
  result
end

def valid_url?(url)
  url =~ URI::regexp(['http', 'https'])
end