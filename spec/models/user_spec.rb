require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:sms_number) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it 'Verifies a token from Twilio' do
    VCR.use_cassette('users#verify') do
      user = create :user, authy_id: '27523812'
      service = TwilioService.new(user)
      # service.get_authy_user
      service.generate_code
      #testing with real code and saving to VCR
      byebug
      response = user.verify(ENV['AUTHY_TOKEN'])
      byebug
      expect(response[:success]).to eq('success')
    end
  end
end
