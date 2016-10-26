class API
  def self.generate_new_api
    new.generate_api
  end

  def generate_api
    SecureRandom.uuid
  end
end
