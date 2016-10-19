class TwilioService
  def initialize(user)
    @user = User.find(user) || User.new(user)
  end

  def generate_code

  end

  def conn
    Faraday.new(:url => "https://api.authy.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      # faraday.params[:phone_number] = current_user.oauth_token
    end
  end
end
