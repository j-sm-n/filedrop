require 'rails_helper'

describe 'Folder' do
  context 'user deactivated' do
    it 'cannot be viewed' do
      #as a visitor
      user = create :user
      login(user)

      #when a folder's owner is deactivated
      inactive_user = create :user, email: 'old@example.com', status: :deactivated
      folder = create :folder, user: inactive_user, name: 'Antiques'
      #and I visit that folder
      visit folder_path(folder.id)
      #I should get a 404
      expect(page.status_code).to eq(404)
      #and I should not see that folder's content.
      expect(page).to_not have_content('Antiques')
    end
  end
end
