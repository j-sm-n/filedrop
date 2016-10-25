require 'rails_helper'

describe "registered user" do
  it "can login" do
    user = create :user, name: "Emile Garbanzo", email: "example@example.com", password: "password", password_confirmation: "password"
    visit root_path

    within('.navbar-right') do
      click_on 'Login'
    end
    expect(current_path).to eq(login_path)
    fill_in "Email", with: "example@example.com"
    fill_in "Password", with: "password"
    click_button "Login"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as Emile Garbanzo")
  end

end
