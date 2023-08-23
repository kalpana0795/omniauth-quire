# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    # Strategy for Quire
    class Quire < OmniAuth::Strategies::OAuth2
      option :name, 'quire'

      option :client_options, {
        site: 'https://quire.io/',
        authorize_url: 'https://quire.io/oauth',
        token_url: 'https://quire.io/oauth/token',
        api_url: 'https://quire.io/api'
      }

      uid { raw_info['id'] }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email'],
          image: raw_info['image'],
          urls: {
            website: raw_info['website'],
            profile_url: raw_info['url']
          }
        }
      end

      credentials do
        hash = { token: access_token.token }
        hash['refresh_token'] = access_token.refresh_token if access_token.expires? && access_token.refresh_token
        hash['expires_at'] = expires_at if access_token.expires?
        hash['expires'] = access_token.expires?
        hash
      end

      extra { { raw_info: raw_info } }

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= access_token.get(user_profile_api_endpoint).parsed
      end

      private

      def user_profile_api_endpoint
        "#{options[:client_options][:api_url]}/user/id/me"
      end

      def expires_at
        Time.now.to_i + access_token.expires_in.to_i
      end
    end
  end
end
