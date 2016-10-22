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
    folder = Folder.new(name: "Valuables", user_id: user.id, permission_level: 0)
    # container = Container.create(folder_id: folder.id, containable_id: folder.id, containable_type: "folder")
    folder.save

    login(user)
    #When I click on Create Folder
    click_on 'Create Folder'
    # And I fill in the folder name
    fill_in 'Folder name', with: 'Artwork'
    # And I choose the parent folder
    select folder.name, from: 'folder[id]'
    # And I choose the folder's permission level
    find(:css, '#folder_permission_level_public').set(true)
    # And I click submit
    click_on "Create Folder"
    #I should see a message stating the folder was created
    expect(page).to have_content('Artwork was added')
    # And I should see the folder on this page
    #within?? do
    expect(page).to have_content('Artwork')
    #end
    # And the users count of folders should increase by one.
    expect(user.folders.count).to eq(2)
    expect(folder.subfolders.count).to eq(1)
  end
end
