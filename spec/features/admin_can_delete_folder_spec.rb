require 'rails_helper'

describe 'Folder' do
  it 'can be deleted by an admin' do
    # As a platform admin who is logged in
    user = create :user
    create :folder, name: 'Junk Folder', user: user

    admin = create :user, email: 'admin@example.com'
    admin.admin!
    login(admin)
    #when i visit a folder
    visit user_folders_path(user)
    # Then I should see a list of all content with links to delete next to each entry
    expect(page).to have_content('Junk Folder')
    # And when I click "Delete" next to an entry
    click_on 'Delete'
    # Then I should see a message stating that the entry has been deleted
    expect(page).to have_content('Folder deleted.')
    # Then I should be sent back to /all_files
    expect(current_path).to eq('')
    # And I should see that the folder I deleted is no longer there
    expect(page).to_not have_content('Junk Folder')
  end
end
