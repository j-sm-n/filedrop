require 'rails_helper'

describe 'Registered User' do
  it 'sees a form to create folders' do
    # As a registered user
    user = create :user
    login(user)
    # When I visit the dashboard page
    expect(current_path).to eq(dashboard_path)
    # And I click on Create Folder
    click_on 'Create Folder'
    # I should see a form to create a Folder.
    expect(page).to have_content('Folder name')
    expect(page).to have_content('Parent folder')
    expect(page).to have_content('Public')
    expect(page).to have_content('Private')
  end

  it 'can create a public folder' do
    #As a registered users
    user = create :user
    folder = user.folders.create(attributes_for :folder)
    login(user)
    #When I click on Create Folder
    click_on 'Create Folder'
    # And I fill in the folder name
  
    fill_in 'Folder name', with: 'Artwork'
    # And I choose the parent folder
    select folder.id, from: 'id'
    # And I choose the folder's permission level
    # And I click submit
    #I should see a message stating the folder was created
    # And I should see the folder on this page
  end
end
