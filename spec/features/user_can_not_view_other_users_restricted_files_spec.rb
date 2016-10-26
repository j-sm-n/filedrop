require 'rails_helper'

describe 'Registered user' do
  it 'cannot view another users restricted files' do
    # As a registered user
    user = create :user
    another_user = create :user, email: 'emile@example.com'
    create :folder, user: another_user, name: 'Turing', permission_level: 1
    create :folder, user: another_user, name: 'Students', permission_level: 0
    # When I log into the site
    login(user)
    # And I visit another users page
    visit user_folders_path(another_user)
    # I should not see their restricted folders
    expect(page).to_not have_content "Students"
    # And I should see their unrestricted folders
    expect(page).to have_content "Turing"
  end
end
