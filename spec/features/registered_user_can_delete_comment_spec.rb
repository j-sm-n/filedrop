require 'rails_helper'

describe 'Registered User' do
  it 'can delete any comment on a document they have access to' do
    user     = create(:user)
    folder   = user.folders[0]
    document = folder.documents.create(document_attrs(user))

    document.comments.create(user_id: user.id,
                             content: "Such a helpful screenshot")
    document.comments.create(user_id: user.id,
                             content: "You missed a word.")

    login(user)
    visit user_document_path(user.id, document.id)

    within('.comments') do
      expect(page).to have_selector('.comment', count: 2)
      expect(page).to have_content("Such a helpful screenshot")
      expect(page).to have_content("You missed a word.")
    end

    within(first('.comment')) do
      click_on "Delete"
    end

    within('.comments') do
      expect(page).to have_selector('.comment', count: 1)
      expect(page).to_not have_content("Such a helpful screenshot")
      expect(page).to have_content("You missed a word.")
    end
  end

  def document_attrs(user)
    { filename: "screenshot.png",
      content_type: "image/png",
      user_id: user.id,
      url: "https://filedrop-bucket.s3-us-west-1.amazonaws.com/screenshot.png"
    }
  end
end
