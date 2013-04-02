require 'rubygems'
require 'spork'


Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'

  if ENV['COVERAGE']
    require 'simplecov'

    SimpleCov.start 'rails'
    #SimpleCov.start 'rails' do
      #add_filter "/app/admin/"
      #add_filter '/config/'
      #add_filter do |source_file|
      #  source_file.lines.count < 5
      #end
      #add_filter do |source_file|
      #  source_file.src.include? "ActiveAdmin"
      #end
    #end
  end


  require File.expand_path('../../config/environment', __FILE__)

  require 'rspec/rails'
  require 'factory_girl'
  require 'capybara/rspec'
  require 'database_cleaner'

  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    config.include SeedHelpers
    config.include UrlHelper
    config.include Devise::TestHelpers, :type => :controller

    config.run_all_when_everything_filtered = true
    #config.fixture_path                               = "#{::Rails.root}/spec/fixtures"

    # --seed 1234
    config.order                            = 'random'


    config.before(:suite) do
      # DatabaseCleaner.clean_with :truncation
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end

    config.before(:each, js: true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.after(:each, js: true) do
      Capybara.reset_sessions!
    end


  end
end

Spork.each_run do
  FactoryGirl.reload
  Rails.application.reload_routes!
end if Spork.using_spork?
