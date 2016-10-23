require 'rails_helper'

describe "Authy Verification" do

  it "accepts authy_id" do
    user = create(:user)
    authy_verification = AuthyVerification.new(user)
    authy_verification.accept_authy_id("123456")

    expect(authy_verification.authy_id).to eq("123456")
  end

  it "accepts user verification token" do
    user = create(:user)
    authy_verification = AuthyVerification.new(user)
    authy_verification.accept_token("123456")

    expect(authy_verification.token).to eq("123456")
  end
end
