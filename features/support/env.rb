require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

$PL_HOME = ENV['PL_HOME'] || 'localhost:3000'


Capybara.default_selector = :css
Capybara.default_driver = :selenium
Capybara.app_host = 'http://hostname-of-your-test-server.com'

path_to_chromedriver =       ENV['CHROMEDRIVER_PATH'] ||
                             `find ~+/tmp -type f -name 'chromedriver'`.chomp

path_to_chrome_for_testing = ENV['CHROME_FOR_TESTING_PATH'] ||
                             `find ~+/tmp -type f -name 'Google Chrome for Testing'`.chomp

if (path_to_chromedriver.blank? || path_to_chrome_for_testing.blank?)
  abort "Cannot find Chromedriver and/or ChromeForTesting binaries. Check wiki for instructions."
end

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.add_argument '--headless'
    opts.add_argument '--no-sandbox'
    opts.add_argument '--disable-gpu'
    opts.add_argument '--window-size=1024,1024'
    # When an "unexpected" alert/confirm is displayed, accept it (ie user clicks OK).
    # Expected ones can be handled with accept_alert do...end or accept_confirm do...end
    opts.unhandled_prompt_behavior = :accept
    opts.binary = path_to_chrome_for_testing
  end

  # expects headless Chrome-for-testing and its driver to be in $RAILS_ROOT/tmp somewhere,
  # but puppeteer installs them in arch-specific subdirs :-(
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    service: Selenium::WebDriver::Service.chrome(path: path_to_chromedriver),
    options: options,
    clear_session_storage: true,
    clear_local_storage: true)
end
Capybara.javascript_driver = :selenium_chrome_headless


World(Capybara)
