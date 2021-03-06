require 'rails_helper'

RSpec.describe 'Registered user' do
  it 'sees the page to request and api' do
    user = create :user
    login(user)

    visit user_path(user)

    click_on 'API Keys'

    expect(current_path).to eq('/api_request')
    expect(page).to have_button('Generate API Key')
    expect(page).to have_content('New Application Name:')
  end

  it 'sees the page to with a list of their api keys' do
    user = create :user

    login(user)

    create :external_application, name: 'Api Curious', user_id: user.id, api_key: '12345'

    visit user_path(user)

    click_on 'API Keys'

    expect(current_path).to eq('/api_request')
    expect(page).to have_content('Generate Key')
    expect(page).to have_content('Api Curious')
    expect(page).to have_content('12345')
  end

  it 'can request an api key' do
    user = create :user
    login(user)

    visit user_path(user)

    click_on 'API Keys'

    expect(current_path).to eq('/api_request')

    fill_in 'Application Name', with: 'API Curious'
    click_on 'Generate API Key'

    expect(current_path).to eq('/api_request')
    expect(page).to have_content('API Curious')
    expect(page).to have_content('An email with your new api key has been sent.')
    expect(page).to have_content('Generate Key')
  end

  it 'it does not let user generate an api without a name' do
    user = create :user
    login(user)

    visit user_path(user)

    click_on 'API Keys'

    expect(current_path).to eq('/api_request')

    fill_in 'Application Name', with: ''
    click_on 'Generate API Key'

    expect(current_path).to eq('/api_request')
    expect(page).to have_content('Please try again, API key was not generated.')
    expect(page).to_not have_content('Generate Key')
  end

  xit 'it can generate a new api key for an existing application' do
    user = create :user
    login(user)
    create :external_application, name: 'Api Curious', user_id: user.id, api_key: '12345'

    visit user_path(user)


    click_on 'API Keys'

    expect(current_path).to eq('/api_request')

    click_on "Generate Key"
    expect(current_path).to eq('/api_request')
    expect(page).to have_content("An email with your new api key has been sent.")
    expect(page).to_not have_content('12345')
  end

  it 'it can delete an api key for an existing application' do

    user = create :user
    login(user)
    create :external_application, name: 'Api Curious', user_id: user.id, api_key: '12345'

    visit user_path(user)

    click_on 'API Keys'

    expect(current_path).to eq('/api_request')

    click_on "Delete Key"
    expect(current_path).to eq('/api_request')
    expect(page).to have_content("Your key has been deleted!")
    expect(page).to_not have_content('12345')
  end


end
