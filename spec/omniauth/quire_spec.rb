# frozen_string_literal: true

RSpec.describe OmniAuth::Strategies::Quire do
  let(:client_id) { '123' }
  let(:client_secret) { 'asdfgh' }
  let(:raw_info) { JSON.parse(File.read('./spec/fixtures/raw_info.json')) }
  let(:request) { double('Request') }
  let(:access_token) { double('OAuth2::AccessToken') }

  before do
    allow(request).to receive(:params).and_return({})
  end

  subject do
    args = [client_id, client_secret].compact
    OmniAuth::Strategies::Quire.new(nil, *args).tap do |strategy|
      allow(strategy).to receive(:request).and_return(request)
    end
  end

  it 'has a version number' do
    expect(Omniauth::Quire::VERSION).not_to be nil
  end

  describe '#client' do
    it 'has correct Quire site' do
      expect(subject.client.site).to eq('https://quire.io/')
    end

    it 'has correct authorize url' do
      expect(subject.client.options[:authorize_url]).to eq('https://quire.io/oauth')
    end

    it 'has correct token url' do
      expect(subject.client.options[:token_url]).to eq('https://quire.io/oauth/token')
    end

    it 'has correct api url' do
      expect(subject.client.options[:api_url]).to eq('https://quire.io/api')
    end
  end

  describe '#info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    context 'when data is present in raw info' do
      it 'returns the name' do
        expect(subject.info[:name]).to eq(raw_info['name'])
      end

      it 'returns the email' do
        expect(subject.info[:email]).to eq(raw_info['email'])
      end

      it 'returns the image' do
        expect(subject.info[:image]).to eq(raw_info['image'])
      end

      it 'returns the urls' do
        expected_urls = {
          website: raw_info['website'],
          profile_url: raw_info['url']
        }

        expect(subject.info[:urls]).to eq(expected_urls)
      end
    end
  end

  describe '#credentials' do
    before :each do
      allow(access_token).to receive(:token).and_return('xxxxx')
      allow(access_token).to receive(:expires?)
      allow(access_token).to receive(:expires_at)
      allow(access_token).to receive(:expires_in)
      allow(access_token).to receive(:refresh_token)
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    it 'returns a Hash' do
      expect(subject.credentials).to be_a(Hash)
    end

    it 'returns the token' do
      expect(subject.credentials['token']).to eq('xxxxx')
    end

    it 'returns the expiry status' do
      allow(access_token).to receive(:expires?) { true }
      expect(subject.credentials['expires']).to eq(true)

      allow(access_token).to receive(:expires?) { false }
      expect(subject.credentials['expires']).to eq(false)
    end

    it 'returns the refresh token and expiry time when expiring' do
      ten_mins_from_now = (Time.now + 360).to_i

      allow(access_token).to receive(:expires?) { true }
      allow(access_token).to receive(:refresh_token) { 'yyyyyy' }
      allow(access_token).to receive(:expires_in) { 360 }

      expect(subject.credentials['refresh_token']).to eq('yyyyyy')
      expect(subject.credentials['expires_at']).to eq(ten_mins_from_now)
    end

    it 'does not return the refresh token when it is nil and expiring' do
      allow(access_token).to receive(:expires?) { true }
      allow(access_token).to receive(:refresh_token) { nil }

      expect(subject.credentials['refresh_token']).to be_nil
      expect(subject.credentials).to_not have_key('refresh_token')
    end

    it 'does not return the refresh token when not expiring' do
      allow(access_token).to receive(:expires?) { false }
      allow(access_token).to receive(:refresh_token) { 'zzzzz' }

      expect(subject.credentials['refresh_token']).to be_nil
      expect(subject.credentials).to_not have_key('refresh_token')
    end
  end
end
