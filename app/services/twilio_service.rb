class TwilioService
  def initialize(user)
    @user = User.find(user) || User.new(user)
  end
  #get authy user

  def get_authy_user(user)
    response = conn.post "/protected/json/users/new"
    response = conn.post do |req|
      req.url "/protected/json/users/new"
      req.params['user[email]'] = user.email
      req.params['user[country_code]'] = 1
      req.params['user[cell_phone]'] = user.sms_number
    end
    require "pry"; binding.pry
    parse(response)
  end

  #generate code
  def generate_code
    response = conn.get "/protected/json/sms/#{@user.authy_id}"
    parse(response)
  end
  #verify token
  def verify(token)
    response = conn.get "/protected/json/verify/#{token}/#{@user.authy_id}"
    parse(response)
  end

  private
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
