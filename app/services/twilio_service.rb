class TwilioService
  def initialize(user)
    @user = User.find(user) || User.new(user)
  end
  #get authy user

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
