require 'rails_helper'

RSpec.describe 'Registered user' do
  it 'can request an api key' do
    user = create :user
    login(user)

    visit user_path(user)

    click_on 'Request API Key'

    expect(current_path).to eq('/api_request')

    fill_in 'Application Name', with: 'API Curious'
    click_on 'Create API Key'

    expect(page).to have_content('API Key for API Curious')
    expect(current_path).to eq(user_path(user))
  end
end
