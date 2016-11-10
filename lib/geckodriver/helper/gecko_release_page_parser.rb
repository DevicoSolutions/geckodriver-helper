require 'open-uri'
require 'json'

module Geckodriver
  class Helper
    class GeckoReleasePageParser
      GIT_API_URL = 'https://api.github.com/repos/mozilla/geckodriver/releases'

      attr_reader :platform

      def initialize(platform)
        @platform = platform
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
        result = JSON.parse(open(GIT_API_URL).read)
        download_url(result)
      end
    end
  end
end

