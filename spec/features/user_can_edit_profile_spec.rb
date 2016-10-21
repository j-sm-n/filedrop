require 'rails_helper'

describe 'Registered user' do
  it 'can update email' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))

    expect(page).to have_content("example@example.com")

    fill_in :email, with: 'NewEmail@example.com'
    click_on "Update Profile"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('NewEmail@example.com')
    expect(page).to have_content('Your account has been updated')

  end

  it 'can update password' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))
    user_password = user.password_digest

    fill_in :password,               with: 'NewPassword'
    fill_in :password_confirmation,  with: 'NewPassword'
    click_on "Update Profile"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Your account has been updated')
    expect(user_password).to_not eq(User.last.password_digest)
  end

  it 'can update name' do
    user = create :user
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path
    click_on "Edit Profile"
    expect(current_path).to eq(edit_user_path(user))

    expect(page).to have_content("Users Name")

    fill_in :name, with: "New Name"
    click_on "Update Profile"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('New Name')
    expect(page).to have_content('Your account has been updated')
  end
end
