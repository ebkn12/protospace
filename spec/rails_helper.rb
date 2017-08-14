require 'spec_helper'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'rails-controller-testing'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include ActionDispatch::TestProcess

  FactoryGirl::SyntaxRunner.class_eval do
    include ActionDispatch::TestProcess
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  %i[controller view request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end
end
