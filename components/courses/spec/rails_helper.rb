# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../spec/dummy/config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'pry-rails'
require 'capybara/rails'
require 'factory_girl_rails'
require 'faker'

Dir[Courses::Engine.root.join('spec/support/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

FactoryGirl.definition_file_paths << Courses::Engine.root.join('spec', 'factories')

Dir['../spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:all) do
    if ENV['CI']
      FactoryGirl.find_definitions
      FactoryGirl.reload
    end
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Courses::Test::FeaturesHelpers, type: :feature
  config.include Courses::Test::DatePickerHelpers
end
