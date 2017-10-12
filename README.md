# geckodriver-helper

[![Build status](https://travis-ci.org/DevicoSolutions/geckodriver-helper.svg)](https://travis-ci.org/DevicoSolutions/geckodriver-helper)

Easy installation and use of [geckodriver](https://github.com/mozilla/geckodriver), that provides the HTTP API 
described by the WebDriver protocol to communicate with Gecko browsers, such as Firefox.

* [https://github.com/DevicoSolutions/geckodriver-helper](https://github.com/DevicoSolutions/geckodriver-helper)


# Description

`geckodriver-helper` installs an executable, `geckodriver`, in your
gem path.

This script will, if necessary, download the appropriate binary for
your platform and install it into `~/.geckodriver-helper`, then exec
it.

# Usage

If you're using Bundler and Capybara, it's as easy as:

    # Gemfile
    gem 'geckodriver-helper'

then, in your specs:

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end


# Updating Geckodriver

If you'd like to force-upgrade to the latest version of geckodriver,
run the script `gecko_updater`


# License

MIT licensed, see LICENSE.txt for full details.


# Credit

The idea and some features comes from [@flavorjones's](https://github.com/flavorjones) project
`chromedriver-helper`. That saves setup time and works pretty good from the box.

