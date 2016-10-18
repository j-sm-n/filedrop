require 'rails_helper'

describe "Guest Landing Page" do
  it "greets visitors with call to action" do
    # As a guest,
    # When I visit the root path,
    # Then I see a button to create an account,
    # And I see a button to Login,
    # And I see a button to View All Public Files
    visit root_path

    expect(page).to have_button("Create Account")
    expect(page).to have_button("Login")
    expect(page).to have_button("Public Files")
  end
end
