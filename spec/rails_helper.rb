ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl_rails'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'faker'
require 'simplecov'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

Capybara.default_wait_time = 5
Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 100
  Capybara::Selenium::Driver.new(app,
                                 browser: :firefox, http_client: http_client)
end

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
  provider: 'twitter',
  uid: '123456',
  info: { name: 'name', nickname: 'NickName' },
  credentials: { token: 'TOKEN' }
)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL
  config.include Warden::Test::Helpers
  config.include ActiveJob::TestHelper

  # Spork.each_run { FactoryGirl.reload }

  config.before(:all) do
    FactoryGirl.factories.clear
    FactoryGirl.sequences.clear
    FactoryGirl.find_definitions
  end

  config.before(:suite) do
    I18n.locale = :ja
    Faker::Config.locale = :en
    Warden.test_mode!
    begin
      FactoryGirl.lint
    ensure
      DatabaseRewinder.clean_all
    end
  end
end
