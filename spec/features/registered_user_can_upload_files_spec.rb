require 'rails_helper'

describe "Registered User" do
  it "can upload files" do
    # As a Registered User,
    user      = create(:user)
    folder    = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    document  = Document.create(user_id: user.id)
    folder.documents << document

    expect(folder.documents.count).to eq(1)
    # After I log in,
    login(user)
    # I click on "Upload File,"
    click_on "Upload File"
    # And I should see a form to upload a single file,
    expect(current_path).to eq(new_user_document_path(user.id))
    # And I should see "No file chosen" next to a button called "Choose File"
    # expect(page).to have_content("No file chosen")
    # And I select a parent folder from a dropdown of existing folders that I own,
    select folder.name, from: "document[id]"
    # And I click the button "Choose File,"
    click_on "document_file"
    # And I select a file from my local machine,
    attach_file "screenshot", "/Users/artemis/Desktop/Screen\ Shot\ 2016-10-21\ at\ 11.08.48\ AM.png"
    # And I should see the name of the file instead of "No file chosen"
    expect(page).to have_content("screenshot")
    # And I click the button "Upload File,"
    click_button("Upload File")
    # And I am taken to a page with the name of the folder I just uploaded to
    expect(current_path).to eq(user_folder_path(user))
    # And I should see a list of the files that are in the folder plus the one I just added,
    expect(page).to have_content(document.filename)
    expect(page).to have_content("screenshot")
    expect(folder.documents.count).to eq(1)
    # And I should see "{file name} added to {folder name} folder"
    expect(page).to have_content("'screenshot' added to Novel folder")
  end
end
