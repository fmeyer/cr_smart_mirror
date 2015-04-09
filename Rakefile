require 'rspec/core/rake_task'
require 'rspec-rerun'

task :default => :help

desc 'Start pry with application environment loaded'
task "console" do
    exec "pry -r./config/environment"
end

desc "Run specs"
task :spec do
    RSpec::Core::RakeTask.new(:spec) do |t|
        t.pattern = './spec/**/*_spec.rb'
    end
end

desc "Show help menu"
task :help do
    puts "Available rake tasks: "
    puts "rake console - Run a Pry console with all enviroment loaded"
    puts "rake spec - Run specs and calculate coverage"
end


desc "Retrieve packages and contents"

end