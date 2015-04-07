require 'simplecov'
SimpleCov.add_filter '/spec/'
SimpleCov.add_filter '/config/'
SimpleCov.start if ENV["COVERAGE"]

ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + "/../config/environment.rb")

require 'capybara'
require 'capybara/rspec'
require 'rspec'


Capybara.app = Sinatra::Application

