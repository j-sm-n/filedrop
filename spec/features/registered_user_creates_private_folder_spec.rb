require 'rails_helper'

describe 'Registered User' do
  it 'creates a private folder' do
    # As a registered user
    user = create :user
    folder = create :folder, name: 'Turing', user_id: user.id
    inital_count = Folder.all.count
    login(user)
    # When I visit the dashboard page
    visit dashboard_path
    # and I click on Create Folder
    click_on 'Create Folder'
    # and I fill in the form
    fill_in 'Folder name', with: 'Students'
    # And I choose the parent folder
    select folder.name, from: 'folder[parent]'
    # and I choose the permission level "Private"
    find(:css, '#folder_permission_level_restricted').set(true)
    # and I click Create Folder
    click_on "Create Folder"
    # I should see a message state the folder was created
    expect(page).to have_content("Students was added to Turing")
    # and the number of folders should increase by one.
    final_count = Folder.all.count
    expect(final_count - inital_count).to eq(1)
    #and the permission level of the new folder is private
    expect(Folder.last.restricted?).to be(true)
  end
end
