require 'open-uri'
require 'nokogiri'
require 'ostruct'


def fetch(url)
  html = Nokogiri::HTML(URI.open(url))
  result = OpenStruct.new

  result.success = true
  result.links = html.css('a').map { |anchor_tag| anchor_tag['href'] }

  result
end