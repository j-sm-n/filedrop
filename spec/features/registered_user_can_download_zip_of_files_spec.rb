require 'rails_helper'

describe "Registered User" do
  xit "can upload files" do
    # As a Registered User,
    user      = create(:user)
    folder    = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    document1 = Document.create(filename: "document1.jpg", user_id: user.id)
    document2 = Document.create(filename: "document2.jpg", user_id: user.id)
    document3 = Document.create(filename: "document3.jpg", user_id: user.id)
    folder.documents << document1
    folder.documents << document2
    folder.documents << document3
    expect(folder.documents.count).to eq(2)

    #When I visit the folder show page
    visit "folders/#{folder.id}"
    #I should see a list of all the files in that folder
    expect(page).to have_content (document1.filename)
    expect(page).to have_content (document2.filename)
    expect(page).to have_content (document3.filename)
    #and I click the checkbox to download next to the first file
    #and I click the checkbox to download next to the second file
    #and I click "Submit"
    #then a zip file should be downloaded to my machine
  end
end
