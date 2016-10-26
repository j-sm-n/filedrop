class ExternalApplicationController < ApplicationController
  def new
    @application = ExternalApplication.new
  end

  def create
    api_key = API.generate_api_key
    @application = ExternalApplication.create(name: ext_app_params[:name],
                                              api_key: api_key,
                                              user_id: current_user.id)
    
  end

  private
    def ext_app_params
      params.require(:external_application).permit(:name)
    end
end
