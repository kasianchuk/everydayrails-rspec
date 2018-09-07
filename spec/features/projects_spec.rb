require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  # include LoginSupport
  scenario 'user creates a new project' do

    user = FactoryBot.create(:user)

    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'
    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content "Owner: #{user.name}"
    end
  end
  scenario 'guest adds a project' do
    visit projects_path
    # save_and_open_page зберігає сторінку і грузить її джем launchy
    click_link 'Projects'
  end

  scenario 'user creates a new project DRY' do
    user = FactoryBot.create(:user)
    # sign_in_as user my custom login module
    login_as user, scope: :user # devise registration
    visit root_path

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'
    }.to change(user.projects, :count).by(1)

    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'Test Project'
    expect(page).to have_content "Owner: #{user.name}"
  end
end
