require 'rails_helper'

describe 'Registered user' do
  it 'can update email' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "My Account"

    expect(page).to have_content("example@example.com")

    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))

    fill_in 'Email', with: 'NewEmail@example.com'
    click_on "Update Profile"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('NewEmail@example.com')
    expect(page).to have_content('Your account has been updated')

  end

  it 'can update password' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "My Account"

    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))
    user_password = user.password_digest

    fill_in 'Edit Password',         with: 'NewPassword'
    fill_in 'Confirm Password', with: 'NewPassword'
    click_on "Update Profile"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('Your account has been updated')
    expect(user_password).to_not eq(User.last.password_digest)
  end

  it 'can update name' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "My Account"

    expect(page).to have_content("Account Name")

    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))

    fill_in 'Name', with: "New Name"
    click_on "Update Profile"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('New Name')
    expect(page).to have_content('Your account has been updated')
  end
end
