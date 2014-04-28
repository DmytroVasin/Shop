# require 'rubygems'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start 'rails'
end


require 'rspec/rails'
require 'factory_girl'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'database_cleaner'
require 'email_spec'
require 'capybara/email/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include SeedHelpers
  config.include UrlHelper
  config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
  Capybara.server_port = 56565

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {js_errors: false})
  end

  Capybara::Screenshot.autosave_on_failure = true
end
