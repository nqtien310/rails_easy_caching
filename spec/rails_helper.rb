require 'rubygems'
require 'bundler/setup'
require 'rails'
require 'active_record'
require 'spec_helper'
require 'byebug'
Bundler.require(:default)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = "random"
  config.mock_with :rspec
end
