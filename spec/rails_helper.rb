ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'factory_girl_rails'
require 'shoulda/matchers'
require 'rspec/rails'
require 'capybara/email/rspec'
require 'faker'
require 'simplecov'
require 'capybara/poltergeist'
require 'rspec/json_matcher'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end

SimpleCov.start 'rails'
RSpec.configuration.include RSpec::JsonMatcher

ActiveRecord::Migration.maintain_test_schema!

# TODO: OmniAuthを利用した際に追加
# OmniAuth.config.test_mode = true

# OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
#   provider: 'twitter',
#   uid: '123456',
#   info: { name: 'name', nickname: 'NickName' },
#   credentials: { token: 'TOKEN' }
# )

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
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
    begin
      FactoryGirl.lint
    ensure
      DatabaseRewinder.clean_all
    end
  end
end
