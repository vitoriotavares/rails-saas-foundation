require 'capybara/rails'
require 'capybara/rspec'

Capybara.configure do |config|
  config.default_driver = :rack_test
  config.javascript_driver = :selenium_headless_chrome
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_headless_chrome
  end
end