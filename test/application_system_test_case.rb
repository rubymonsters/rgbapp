require "test_helper"
require 'capybara/email'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Capybara::Email::DSL
  include ActiveJob::TestHelper
  driven_by :headless_chrome
end
