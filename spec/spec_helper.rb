require 'simplecov'
SimpleCov.add_filter '/spec/'
SimpleCov.add_filter '/config/'
SimpleCov.start if ENV["COVERAGE"]

ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + "/../config/environment.rb")

require 'capybara'
require 'capybara/rspec'
require 'rspec'

module Fixture 
    FIXTURES_DIR = File.expand_path(File.dirname(__FILE__)+ "/fixtures")

    def self.load(name)
        File.open(FIXTURES_DIR+"/"+name).read
    end
end

Capybara.app = Sinatra::Application

Package.delete_all


