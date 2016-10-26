require 'rails_helper'

describe 'Root Folder' do
  it 'is created when a user is created' do
    #As a registered User
    user = create :user, name: 'Weeble'
    login(user)
    # When I visit the folders_path without creating folders
    visit user_folders_path(user.id)
    # I should see a root folder
    expect(page).to have_content("Weeble's Stuff")
  end
end
