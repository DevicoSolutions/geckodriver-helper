# frozen_string_literal: true

require 'geckodriver/helper/version'
require 'fileutils'
require 'rbconfig'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'rubygems/package'

module Geckodriver
  class Helper
    DRIVER_VERSION = "v0.24.0".freeze

    def run *args
      download
      exec binary_path, *args
    end

    def download hit_network=false
      return if File.exists?(binary_path) && !hit_network
      url = download_url
      filename = File.basename url
      Dir.chdir platform_install_dir do
        FileUtils.rm_f filename
        File.open(filename, 'wb') do |saved_file|
          URI.parse(url).open('rb') do |read_file|
            saved_file.write(read_file.read)
          end
        end
        raise "Could not download #{url}" unless File.exists? filename
        unpack_archive(filename)
      end

      raise "Could not unarchive #{filename} to get #{binary_path}" unless File.exists? binary_path
      FileUtils.chmod 'ugo+rx', binary_path
    end

    def unpack_archive(file)
      case file
      when /\.zip$/
        unzip(file)
      when /\.tar\.gz$/
        io = ungzip(file)
        untar(io)
      else
        raise "Don't know how to unpack #{file}"
      end
    end

    def update
      download true
    end

    def download_url
      extension = platform.include?('win') ? 'zip' : 'tar.gz'
      "https://github.com/mozilla/geckodriver/releases/download/#{DRIVER_VERSION}/geckodriver-#{DRIVER_VERSION}-#{platform}.#{extension}"
    end

    def binary_path
      exe = if platform.include?('win')
              'geckodriver.exe'
            else
              'geckodriver'
            end

      File.join platform_install_dir, exe
    end

    def platform_install_dir
      dir = File.join install_dir, platform
      FileUtils.mkdir_p dir
      dir
    end

    def install_dir
      dir = File.expand_path File.join(ENV['HOME'], '.geckodriver-helper')
      FileUtils.mkdir_p dir
      dir
    end

    def platform
      @platform ||= begin
        cfg = RbConfig::CONFIG
        case cfg['host_os']
        when /linux/
          append_64_or_32('linux', cfg)
        when /darwin/
          'macos'
        else
          append_64_or_32('win', cfg)
        end
      end
    end

    private

    def append_64_or_32(platform, cfg)
      cfg['host_cpu'] =~ /x86_64|amd64/ ? "#{platform}64" : "#{platform}32"
    end

    def unzip(zipfile)
      Archive::Zip.extract(zipfile, '.', :overwrite => :all)
    end

    def ungzip(tarfile)
      z = Zlib::GzipReader.open(tarfile)
      unzipped = StringIO.new(z.read)
      z.close
      unzipped
    end

    def untar(io)
      Gem::Package::TarReader.new io do |tar|
        tar.each do |tarfile|
          destination_file = tarfile.full_name
          File.open destination_file, 'wb' do |f|
            f.print tarfile.read
          end
        end
      end
    end
  end
end
