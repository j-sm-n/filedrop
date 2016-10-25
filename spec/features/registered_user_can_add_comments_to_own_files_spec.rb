require 'rails_helper'

describe 'Registered User' do
  it 'can comment on own files' do
    # As a registered user,
    user        = create(:user, name: "Stu")
    folder      = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    document_1  = Document.create(document_1_attrs)
    document_2  = Document.create(document_2_attrs)
    document_3  = Document.create(document_3_attrs)
    folder.documents << [document_1, document_2, document_3]
    # I log in and am on my dashboard,
    login(user)
    expect(current_path).to eq(dashboard_path)
    # When I click on the link 'My Files,'
    click_link 'My Files'

    expect(current_path).to eq(user_documents_path(user))

    # I should see a list of all of my files ordered by creation date with most recent at the top,
    expect(page).to have_selector('.user_folder', count: 1)

    within('.user_folder') do
      expect(page).to have_content("Novel")
    end

    within('.user_folder_files') do
      expect(page).to have_selector('.user_folder_file', count: 3)

      within(first('.folder_file')) do
        expect(page).to have_content("ch-2-beccas-revenge.txt")
      end

      within(last('.folder_file')) do
        expect(page).to have_content("screenshot.png")
      end
    end
    # When I click on the first file listed,
    click_on "ch-2-beccas-revenge.txt"

    # I should see the specific file's contents,
    expect(current_path).to eq(user_document_path(user, document_3))
    expect(page).to have_content("ch-2-beccas-revenge.txt")
    # And I should see all comments associated with that file,
    # And I should see an empty input field for a new comment,
    # When I fill in the comment field with text,
    fill_in "Comment", with: "This is some riveting stuff"
    # When I click 'Add Comment,'
    # I should see my comment added to the list of all comments.
  end

  def document_1_attrs
    { filename: "screenshot.png",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/screenshot.png"
    }
  end

  def document_2_attrs
    { filename: "cover.jpeg",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/cover.jpeg"
    }
  end

  def document_3_attrs
    { filename: "ch-2-beccas-revenge.txt",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/ch-2-beccas-revenge.txt"
    }
  end
end
