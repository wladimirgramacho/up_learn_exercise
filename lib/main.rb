require 'open-uri'
require 'nokogiri'
require 'ostruct'

def fetch(url)
  return OpenStruct.new(success: false, error: 'Invalid URL') unless valid_url?(url)

  html_doc = Nokogiri::HTML(URI.open(url))

  OpenStruct.new(
    success: true,
    links: extract_links_from_tag(html_doc, 'a', 'href'),
    assets: extract_links_from_tag(html_doc, 'img', 'src')
  )
rescue StandardError => error
  OpenStruct.new(success: false, error: "Couldn't fetch the url. Error: #{error.inspect}")
end

def extract_links_from_tag(html_doc, html_tag, attribute)
  html_doc.css(html_tag).map { |tag| tag[attribute] }.filter(&method(:valid_url?))
end

def valid_url?(url)
  url =~ URI::regexp(['http', 'https'])
end