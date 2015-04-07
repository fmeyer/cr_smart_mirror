# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'yaml'

require 'uri'
require 'pathname'

require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('lib', '**' ,'*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

env = ENV['RACK_ENV'] ||= "development"

# Configure
Config.configure do |config|
    config_env = YAML::load_file(File.join(__dir__, 'config.yml'))[env]
    config_env.each do |key, value|
        config.send("#{key}=",value)
    end
end

# Configure Sinata env
configure do
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || '1ee391a8e0305103fdabfe8679a47e3096b9458ead72068135c1b6a5faaf9209'

  # Set the views to
  set :views, File.join(APP_ROOT, "app", "views")
end

