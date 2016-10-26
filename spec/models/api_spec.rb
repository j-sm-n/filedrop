require 'rails_helper'

describe API, type: :model do
  it 'Generates a uniq api key' do
    api_key = API.generate_new_api

    expect(api_key.class).to eq(String)
    expect(api_key.length).to eq(36)
  end
end
