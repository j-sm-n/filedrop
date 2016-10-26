class NotificationController < ApplicationController
  def create
    ApiNotifierMailer.send_api(current_user, params[:email]).deliver_now
    flash[:info] = "Api was sent to applicant"
    redirect_to dashboard_path
  end
end
