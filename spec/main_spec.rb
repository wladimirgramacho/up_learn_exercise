require_relative '../lib/main'

RSpec.describe 'fetch method' do
  let(:url) { '' }
  let(:html) { '' }

  subject { fetch(url) }

  # Assuming open-uri is properly tested
  before { allow(URI).to receive(:open).with(url).and_return(html) }

  describe 'returns links on page' do
    let(:url) { 'https://google.com' }
    let(:html) { "<a href=https://google.com>Google</a>" }

    it { is_expected.to have_attributes(success: true, links: ['https://google.com']) }
  end
end
