require 'spec_helper'

describe Geckodriver::Helper::GeckoReleasePageParser do

  let!(:data) do
    file = File.read(File.join(File.dirname(__FILE__), 'assets/gecko-releases.json'))
    JSON.parse(file)
  end

  describe '#download_url' do
    %w(mac linux32 linux64 win).each do |platform|

      it "returns correspond URL for the #{platform} platform" do
         parser = Geckodriver::Helper::GeckoReleasePageParser.new(platform)
         case platform
           when 'mac' then file = 'macos.tar.gz'
           when 'linux32' then file = 'linux32.tar.gz'
           when 'linux64' then file = 'linux64.tar.gz'
           when 'win' then file = 'win32.zip'
           else raise "#{platform} is not supported"
         end
        expect(parser.download_url(data)).to eq "https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-#{file}"
      end
    end
  end
end
