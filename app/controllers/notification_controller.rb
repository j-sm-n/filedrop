class NotificationController < ApplicationController

  def create
    api_key = API.generate_new_api
    @application = ExternalApplication.new(name: ext_app_params[:name],
                            user_id: current_user.id,
                            api_key: api_key)
    if @application.save
      ApiNotifierMailer.send_api(current_user, current_user.email).deliver_now
      flash[:success] = "An email with your new api key has been sent."
      redirect_to api_request_path
    else
      flash[:warning] = "Please try again, API key was not generated."
      redirect_to api_request_path
    end
  end

  def update
    byebug
    api_key = API.generate_new_api
    @application = ExternalApplication.find_by(user_id: current_user.id, name: ext_app_name)
    if @application.update_attribute(api_key: api_key)
      ApiNotifierMailer.send_api(current_user, current_user.email).deliver_now
      flash[:success] = "An email with your new api key has been sent."
      redirect_to api_request_path
    else
      flash[:warning] = "Please try again, API key was not generated."
      redirect_to api_request_path
    end
  end

  private
    def ext_app_params
      params.require(:notification).permit(:name)
    end

    def ext_app_name
      params.permit(:name)
    end
end
