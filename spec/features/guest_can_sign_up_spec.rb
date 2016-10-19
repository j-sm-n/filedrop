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

  expect(current_path).to eq(new_user_path)

  fill_in "Name", with: 'Emile'
  fill_in 'Email', with: 'email@example.com'
  fill_in 'SMS Number', with: "(303) 555-5555"
  fill_in 'Password', with: 'password'
  fill_in 'Confirm Password', with: 'password'
  click_on 'Create Account'

  expect(current_path).to eq(verify_path)
  expect(page).to have_content('Confirmation Code:')
  fill_in 'Confirmation Code:', with: '1234'
  click_button 'Submit'

  expect(current_path).to eq(dashboard_path)
  expect(page).to have_content('Logged in as Emile')
  expect(page).to have_link('Logout')
  end
end
