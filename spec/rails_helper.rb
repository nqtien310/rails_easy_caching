ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = "random"
  config.mock_with :rspec
end
