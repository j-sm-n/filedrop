require 'rails_helper'

describe 'Guest signup' do
  it 'allows guest to create an account' do
# As a Visitor
# When I visit the home page
# and I click “Create Account”
# and I enter my information
# I should receive a text message confirmation
# and I should be logged in
# and I should see my dashboard page.

  visit root_path
  click_on 'Create Account'

  expect(current_path).to eq(login_path)

  fill_in :name, with: 'Emile'
  fill_in :email, with: 'email@example.com'
  fill_in :sms_number, with: "(303) 555-5555"
  fill_in :password, with: 'password'
  fill_in :password_confirmation, with: 'password'
  click_on 'Create Account'

  # expect(page).to have_content('Confirmation Code:')
  # fill_in
  # click_on 

  expect(current_path).to eq(dashboard_path)
  expect(page).to have_content('Logged in as Emile')
  expect(page).to have_link('Logout')
  end
end
