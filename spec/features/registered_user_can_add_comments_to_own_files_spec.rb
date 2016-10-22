require 'rails_helper'

describe 'Registered User' do
  it 'can comment on own files' do
    # As a registered user,
    user = create(:user)
    # I log in and am on my dashboard,
    login(user)
    expect(current_path).to eq('dashboard_path')
    # When I click on the link 'My Files,'
    click_link 'My Files'
    # I should see a list of all of my files ordered by creation date with most recent at the top,
    within()
    # When I click on the first file listed,
    # I should see the specific file's contents,
    # And I should see all comments associated with that file,
    # And I should see an empty input field for a new comment,
    # When I fill in the comment field with "This is a lovely photo,"
    # When I click 'Add Comment,'
    # I should see my comment added to the list of all comments.
  end
end
