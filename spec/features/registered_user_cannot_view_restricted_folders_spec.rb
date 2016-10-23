require 'rails_helper'

describe 'Regisitered User' do
  context 'has not been granted access to a folder' do
    it 'cannot visit restricted folders' do
      # As a Registered User
      user = create :user
      login(user)
      another_user = create :user, email: 'test@example.com'
      # When I visit a folder path that belongs to another user
      folder = create :folder, user: another_user, permission_level: 'restricted'
      visit 
      # And I do not have access to that folder
      # I should see a 404 message
    end
  end

  context 'has been granted access to a folder' do
    it 'can visit the restricted folders' do
      # As a registered User
      # When I visit a folder path that belongs to another user
      # And I do have access to that folder
      # I should see it's content
      # And I should see options to manage that folder
      # and I should see options to add content
      # And I should not see an option to delete that folder
    end
  end
end
