require 'capybara'
require 'pry'
require 'rspec'
require 'capybara/cucumber'
require 'yaml'
require 'httparty'
require 'capybara/poltergeist'
require 'rubygems'

# Capybara.default_driver = :selenium
Capybara.register_driver :poltergeist do |app|
  options = {
       :js_errors => false,
       :timeout => 180,
       :debug => false,
       :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
       :inspector => true,
       :paper_size => "1080x768"
   }
   Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 60
Capybara.run_server = false
Capybara.ignore_hidden_elements = false

file_content = File.new("#{File.dirname(__FILE__)}/../config/applications.yml").read
$env = YAML.load(file_content)
