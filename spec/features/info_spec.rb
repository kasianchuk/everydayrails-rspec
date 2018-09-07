require 'rails_helper'

RSpec.feature "Info", type: :feature do
  scenario 'runs a really slow process' do
    original_wait_time = Capybara.default_max_wait_time
    Capybara.default_max_wait_time = 15
    Capybara.default_max_wait_time = original_wait_time
  end
 end
