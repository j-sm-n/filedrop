require 'rails_helper'

describe "Registered User" do
  it "can see all files listed in a single folder" do
    user        = create(:user)
    folder      = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    document_1  = Document.create(filename: "Ch. 43 - Sarah Finds a New Lover", user_id: user.id)
    document_2  = Document.create(filename: "Ch. 44 - Sarah's Lover Dies", user_id: user.id)
    document_3  = Document.create(filename: "Ch. 45 - Sarah Finds a New Lover Pt. 2", user_id: user.id)
    folder.documents << [document_1, document_2, document_3]

    login(user)

    visit folder_path(folder.id)

    expect(page).to have_content(document_1.filename)
    expect(page).to have_content(document_2.filename)
    expect(page).to have_content(document_3.filename)
  end
end
