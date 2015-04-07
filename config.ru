# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

if development? 
    require 'rack-livereload'
    use Rack::LiveReload
end

run Sinatra::Application
