require 'capybara/poltergeist'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    args: ["headless"], # не показує запуск тестів у новому вікні
  )
end

Capybara.javascript_driver = :chrome
# Capybara.javascript_driver = :poltergeist

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
end

if ENV["SLOW"].present?
  require "selenium-webdriver"
  module ::Selenium::WebDriver::Remote
    class Bridge
      alias old_execute execute

      def execute(*args)
        sleep(0.1)
        old_execute(*args)
      end
    end
  end
end
