class TwilioService
  def initialize(user)
    @user = User.find(user) || User.new(user)
  end

  def generate_code
    response = conn.get "/sms/#{@user.authy_id}"
    parse(response)
  end

  def conn
    Faraday.new(:url => "https://api.authy.com/protected/json") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      faraday.params[:api_key] = ENV['AUTHY_API_KEY']
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  #get authy user
  #generate code
  #verify token




end
