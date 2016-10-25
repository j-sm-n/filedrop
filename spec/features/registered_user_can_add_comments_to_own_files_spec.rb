require 'rails_helper'

describe 'Registered User' do
  it 'can comment on own files' do
    # As a registered user,
    user        = create(:user)
    folder      = Folder.create(name: "Novel", user_id: user.id, permission_level: 0)
    document_1  = Document.create(document_1_attrs(user))
    document_2  = Document.create(document_2_attrs(user))
    document_3  = Document.create(document_3_attrs(user))
    folder.documents << [document_1, document_2, document_3]
    document_3.comments.create(user_id: user.id,
                               content: "This is my first go at it.")
    document_3.comments.create(user_id: user.id,
                               content: "I may scrap this chapter.")
    # I log in and am on my dashboard,
    login(user)

    visit user_document_path(user.id, document_3)

    # Tests user 'My Files' view
      # expect(current_path).to eq(dashboard_path)
      # # When I click on the link 'My Files,'
      # click_link 'My Files'
      #
      # expect(current_path).to eq(user_documents_path(user))
      #
      # # I should see a list of all of my files ordered by creation date with most recent at the bottom,
      # expect(page).to have_selector('.user_folder', count: 1)
      #
      # within('.user_folder') do
      #   expect(page).to have_content("Novel")
      # end
      #
      # within('.user_folder_files') do
      #   expect(page).to have_selector('.user_folder_file', count: 3)
      #
      #   within(first('.user_folder_file')) do
      #     expect(page).to have_content("screenshot.png")
      #   end
      #
      #   within(:css, ".user_folder_file:last-child") do
      #     expect(page).to have_content("ch-2-beccas-revenge.txt")
      #   end
      # end
      # # When I click on the first file listed,
      # click_on "ch-2-beccas-revenge.txt"

    # I should see the specific file's contents,
    expect(page).to have_content("ch-2-beccas-revenge.txt")
    # And I should see all comments associated with that file,
    within('.comments') do
      expect(page).to have_selector('.comment', count: 2)
      expect(page).to have_content("This is my first go at it.")
      expect(page).to have_content("I may scrap this chapter.")
    end
    # And I should see an empty input field for a new comment,
    # When I fill in the comment field with text,
    fill_in "comment[content]", with: "This is some riveting stuff"
    # When I click 'Add Comment,'
    click_on "Add Comment"
    # I should see my comment added to the list of all comments.
    within('.comments') do
      expect(page).to have_selector('.comment', count: 3)
      expect(page).to have_content("This is some riveting stuff")
    end
    expect(document_3.comments.count).to eq(3)
  end

  def document_1_attrs(user)
    { filename: "screenshot.png",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/screenshot.png"
    }
  end

  def document_2_attrs(user)
    { filename: "cover.jpeg",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/cover.jpeg"
    }
  end

  def document_3_attrs(user)
    { filename: "ch-2-beccas-revenge.txt",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/ch-2-beccas-revenge.txt"
    }
  end
end
