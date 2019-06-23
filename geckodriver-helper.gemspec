# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
require "geckodriver/helper/version"

Gem::Specification.new do |s|
  s.name        = "geckodriver-helper"
  s.version     = Geckodriver::Helper::VERSION
  s.authors     = ["Devico Solutions"]
  s.email       = ["info@devico.io"]
  s.homepage    = "https://github.com/DevicoSolutions/geckodriver-helper"
  s.summary     = "Easy installation and use of geckodriver."
  s.description = "Easy installation and use of geckodriver, that provides the HTTP API
described by the WebDriver protocol to communicate with Gecko browsers, such as Firefox."
  s.licenses    = ["MIT"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec",   "~> 3.0"
  s.add_development_dependency "rake",    "~> 10.0"
  s.add_development_dependency "http",    "~> 3.0"

  s.add_runtime_dependency "archive-zip", "~> 0.7"
end
