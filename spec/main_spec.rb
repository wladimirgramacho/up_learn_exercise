require_relative '../lib/main'

RSpec.describe 'fetch method' do
  let(:url) { '' }
  let(:html) { '' }

  subject { fetch(url) }

  # Assuming open-uri is properly tested
  before { allow(URI).to receive(:open).with(url).and_return(html) }

  context 'when url is valid' do
    let(:url) { 'https://google.com' }
    let(:html) do
      "<a href='https://google.com'>Google</a><a href='https://bing.com'>Bing</a>"\
      "<img src='https://google.com'>Google</img><img src='https://bing.com'>Bing</img>"
    end

    it 'returns all valid links and assets' do
      is_expected.to have_attributes(
        success: true,
        links: ['https://google.com', 'https://bing.com'],
        assets: ['https://google.com', 'https://bing.com']
      )
    end

    describe 'ignores invalid links' do
      let(:html) do
        "<a href='#'>Google</a><a href='https://bing.com'>Bing</a>"\
        "<img src='data:image/svg+xml;base64,PHN2ZyiLz4='>Google</img><img src='https://bing.com'>Bing</img>"
      end

      it 'returns only valid links' do
        is_expected.to have_attributes(
          success: true,
          links: ['https://bing.com'],
          assets: ['https://bing.com']
        )
      end
    end
  end

  context 'when url is invalid' do
    context 'when url is nil' do
      let(:url) { nil }
      
      it 'returns failure and error message' do
        is_expected.to have_attributes(success: false, error: 'Invalid URL')
      end
    end

    context 'when url does not follow url patterns' do
      let(:url) { 'foobar.com' }

      it 'returns failure and error message' do
        is_expected.to have_attributes(success: false, error: 'Invalid URL')
      end
    end
  end

  context 'when an unknown error happened' do
    let(:url) { 'https://google.com' }

    before { allow(URI).to receive(:open).with(url).and_raise(StandardError, 'What happened') }

    it 'returns failure and error message' do
      is_expected.to have_attributes(
        success: false,
        error: "Couldn't fetch the url. Error: #<StandardError: What happened>"
      )
    end
  end
end
