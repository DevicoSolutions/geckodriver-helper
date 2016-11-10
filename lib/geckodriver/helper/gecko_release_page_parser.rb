require 'faraday'
require 'faraday_middleware'

module Geckodriver
  class Helper
    class GeckoReleasePageParser
      GIT_API_URL = 'https://api.github.com'

      attr_reader :platform

      def initialize(platform)
        @platform = platform
        @conn = Faraday.new(url: GIT_API_URL) do |faraday|
          faraday.request :url_encoded
          faraday.adapter Faraday.default_adapter
          faraday.response :json, :content_type => /\bjson$/
        end
      end

      def download_url(versions)
        download_url = nil
        assets = versions[0]['assets']
        assets.each do |asset|
          link = asset['browser_download_url']
          if link.include? platform
            download_url = link
            break
          end
        end
        download_url
      end

      def latest_release
        response = @conn.get('/repos/mozilla/geckodriver/releases')
        download_url(response.body)
      end
    end
  end
end

