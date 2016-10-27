require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:sms_number) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  xit 'Verifies a token from Twilio' do
    VCR.use_cassette('users#verify') do
      user = create :user, authy_id: ENV['AUTHY_ID']
      service = TwilioService.new(user)
      # service.get_authy_user
      service.generate_code
      #testing with real code and saving to VCR

      response = user.verify(ENV['AUTHY_TOKEN'])

      expect(response[:success]).to eq(true)
    end
  end

  it 'takes dependents out with it when destroyed' do
    user = create :user
    folder = create :folder, user: user

    expect { user.destroy }.to change { Folder.count }.by(-2)
  end

  it 'takes out grandchildren' do
    user = create :user
    root = user.folders.first
    root.subfolders.create(name: 'Test', user: user)
    expect { user.destroy }.to change { Folder.count }.by(-2)
  end

  it 'takes out docuemtns' do
    user = create :user
    root = user.folders.first
    root.subfolders.create(name: 'Test', user: user)
    expect { user.destroy }.to change { Document.count }.by(-1)
  end
end
