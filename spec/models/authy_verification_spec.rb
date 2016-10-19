require 'rails_helper'

describe "Authy Verification" do
  it "accepts authy_user_id and user verification token"
    user = create(:user)
    authy_verification = AuthyVerification.new(user)
    authy_verification.accept_token("123456")

    expect(authy_verification.authy_user_id).to eq(user.authy_user_id)
    expect(authy_verification.token).to eq("123456")
  end
end
