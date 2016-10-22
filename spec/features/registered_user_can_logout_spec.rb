require 'rails_helper'

describe 'Registered user' do
  it "can logout" do
    user = create :user, name: "Emile Garbanzo", email: "example@example.com", password: "password", password_confirmation: "password"

    visit root_path

    within('.navbar-right') do
      click_on 'Login'
    end
    expect(current_path).to eq(login_path)
    fill_in "Email", with: "example@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to_not have_content('Login')

    click_link 'Logout'

    expect(page).to have_content('Login')
    expect(current_path).to eq(root_path)
  end
end
