require 'rails_helper'

describe 'Registered User' do
  it 'can grant access to another users folder' do
    user = create :user
    secret_folder = create :folder, user: user
    login(user)
    other_user = create :user, email: 'other@user.com', name: 'Other User'
    visit folder_path(secret_folder)

    fill_in 'folder[folder_permissions]', with: 'other@user.com'
    click_on 'Grant Access'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Other User has been granted access!")
  end
end
