require 'rails_helper'

describe 'Guest signup' do
  xit 'allows guest to create an account' do
    VCR.use_cassette('guest_signup#verify') do
      visit root_path
      click_on 'Create Account'

      expect(current_path).to eq(new_user_path)

      fill_in "Name", with: 'Emile'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'SMS Number', with: "3035555555"
      fill_in 'Password', with: 'password'
      fill_in 'Confirm Password', with: 'password'
      click_on 'Create Account'

      expect(current_path).to eq(verify_path)
      expect(page).to have_content('Confirmation code:')
      fill_in "authy_verification[token]", with: '1234'
      click_on 'Verify'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Logged in as Emile')
      expect(page).to have_link('Logout')
    end
  end

  it 'guest enters the wrong verification code' do
    VCR.use_cassette('guest_signup#verify_failure') do
      visit root_path
      click_on 'Create Account'

      expect(current_path).to eq(new_user_path)

      fill_in "Name", with: 'Emile'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'SMS Number', with: "3035555555"
      fill_in 'Password', with: 'password'
      fill_in 'Confirm Password', with: 'password'
      click_on 'Create Account'

      expect(current_path).to eq(verify_path)
      expect(page).to have_content('Confirmation code:')
      fill_in "authy_verification[token]", with: '1234'
      click_on 'Verify'

      expect(current_path).to eq(verify_path)
      expect(page).to have_content('Code was not recognized')
    end
  end

  it 'guest with no account asks for Authy code' do
    VCR.use_cassette('guest_signup_no_authy_id') do
      visit verify_path

      expect(current_path).to eq(new_user_path)
    end
  end
end
