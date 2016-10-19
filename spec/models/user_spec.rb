require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:sms_number) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it 'gets a token from Twilio' do
    VCR.use_cassette('users#verify') do
      user = create :user
      token = user.verify
      expect(token).to eq('')
    end
  end
end
