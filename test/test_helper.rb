ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'selenium/webdriver'

Capybara.register_driver :headless_chrome do |app|
 capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
   chromeOptions: { args: %w(headless disable-gpu no-sandbox disable-dev-shm-usage) }
 )

 Capybara::Selenium::Driver.new app,
   browser: :chrome,
   desired_capabilities: capabilities
end
class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
end
