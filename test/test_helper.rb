ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"

# Add FactoryBot support
require "factory_bot_rails"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Include FactoryBot methods
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Include Devise test helpers for integration tests
  include Devise::Test::IntegrationHelpers
end

# Add custom assertions and test helpers
module TestHelpers
  def assert_redirected_to_login
    assert_redirected_to new_user_session_path
  end

  def sign_in_user(user = nil)
    user ||= create(:user)
    post user_session_path, params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
    user
  end
end

class ActiveSupport::TestCase
  include TestHelpers
end

class ActionDispatch::IntegrationTest
  include TestHelpers
end