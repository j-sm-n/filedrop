require 'rails_helper'

describe "Twilio Service" do

  it 'enables two factor authentication for a user' do
    VCR.use_cassette("twilio_service#get_authy_user") do
      user = create :user, sms_number: ENV['TEST_PHONE_NUMBER']
      service = TwilioService.new(user)
      response = service.get_authy_user
byebug
      expect(response[:success]).to eq(true)
    end
  end

  it "sends a text message to user's number" do
    VCR.use_cassette("twilio_service#post") do
      user = create(
        :user,
        authy_id: ENV['AUTHY_ID']
      )
      service = TwilioService.new(user)
      response = service.generate_code

      expect(response[:success]).to eq(true)
    end
  end

  xit "verifies the user's confirmation code" do
    VCR.use_cassette("twilio_service#verify") do
      user = create(
        :user, 
        authy_id: ENV['AUTHY_ID']
      )
      service = TwilioService.new(user)
      service.generate_code
 byebug
      response = service.verify(ENV['AUTHY_TOKEN'])
 byebug
      expect(response[:success]).to eq(true)
    end
  end
end
