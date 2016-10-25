class TwilioService
  def initialize(user)
    if user.id
      @user = User.find(user.id)
    else
      @user = User.new(user.attributes)
    end
  end
  #get authy user
  def get_authy_user
    response = conn.post do |req|
      req.url "/protected/json/users/new"
      req.params['user[email]'] = user.email
      req.params['user[country_code]'] = 1
      req.params['user[cellphone]'] = user.sms_number
    end
    parse(response)
  end
  #generate code
  def generate_code
    response = conn.get "/protected/json/sms/#{user.authy_id}"
    parse(response)
  end
  #verify token
  def verify(token)
    response = conn.get "/protected/json/verify/#{token}/#{user.authy_id}"
    parse(response)
  end

  private
  attr_reader :user

    def conn
      Faraday.new(:url => "https://api.authy.com") do |faraday|
        faraday.adapter(Faraday.default_adapter)
        faraday.params[:api_key] = ENV['AUTHY_API_KEY']
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
