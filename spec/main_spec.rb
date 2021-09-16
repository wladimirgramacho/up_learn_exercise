require_relative '../lib/main'

RSpec.describe 'fetch method' do
  let(:url) { '' }
  let(:html) { '' }

  subject { fetch(url) }

  # Assuming open-uri is properly tested
  before { allow(URI).to receive(:open).with(url).and_return(html) }

  describe 'returns links on page' do
    let(:url) { 'https://google.com' }
    let(:html) { "<a href='https://google.com'>Google</a><a href='https://bing.com'>Bing</a>" }

    it 'returns all links' do
      is_expected.to have_attributes(
        success: true,
        links: ['https://google.com', 'https://bing.com']
      )
    end
  end

  describe 'returns assets on page' do
    let(:url) { 'https://google.com' }
    let(:html) { "<img src='https://google.com'>Google</img><img src='https://bing.com'>Bing</img>" }

    it 'returns all links' do
      is_expected.to have_attributes(
        success: true,
        assets: ['https://google.com', 'https://bing.com']
      )
    end
  end
end
