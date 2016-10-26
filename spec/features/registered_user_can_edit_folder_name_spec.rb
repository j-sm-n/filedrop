require 'rails_helper'

describe 'Registered user' do
  it 'can edit folder name' do
    #as a registered user
    user = create :user
    folder    = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    #when I visit an individual folder's show page
    visit folder_path(folder.id)
    expect(current_path).to eq (folder_path(folder.id))
    expect(page).to have_content("Novel")
    #and I click on Edit
    click_on "Edit Folder"
    #then I see a form which allows me to edit the name of the folder
    expect(current_path).to eq(edit_user_folder_path(user.id, folder.id))
    #and I change the folder name from "Novel" to "Bobblehead Collection"
    fill_in 'Name', with: "Bobblehead Collection"
    #and I click on "Update Folder"
    click_on "Update Folder"
    #Then I should see the individual folder's show page
    expect(current_path).to eq(folder_path(folder.id))
    #and I should see the updated folder name
    expect(page).to have_content('Bobblehead Collection')
    #and I should not see the folder's old name
    expect(page).to have_no_content('Novel')
  end
end
