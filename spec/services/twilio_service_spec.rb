require 'rails_helper'

describe "Twilio Service" do
  it "sends a text message to user's number" do
    VCR.use_cassette("twilio_service#post") do
      user = create :user, sms_number: "503-547-7488"
      service = TwilioService.new(user)
      response = service.generate_code

      expect(response[:success]).to eq("true")
      expect(response[:is_cellphone]).to eq("true")
      # expect(response[:message]).to eq("")
    end
  end

  it "verifies the user's confirmation code" do
    VCR.use_cassette("twilio_service#verify") do
      user = create :user, sms_number: "503-547-7488"
      service = TwilioService.new(user)
      response = service.generate_code

      expect(response[:success]).to eq("true")
      expect(response[:is_cellphone]).to eq("true")
      # expect(response[:message]).to eq("")
    end
  end
end
