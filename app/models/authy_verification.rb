class AuthyVerification
  include ActiveModel::Model
  attr_reader :email, :sms_number, :country_code, :token, :authy_id

  def initialize(current_user)
    @email = current_user.email
    @sms_number = current_user.sms_number
    @country_code = "1"
  end

  def accept_authy_id(authy_id)
    @authy_id = authy_id
  end

  def accept_token(token)
    @token = token
  end


end
