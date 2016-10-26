class NotificationController < ApplicationController

  def new
    # @application = Application.new
  end

  def create
    byebug
    ApiNotifierMailer.send_api(current_user, current_user.email ).deliver_now
    flash[:info] = "Api was sent to applicant"
    redirect_to dashboard_path
  end
end
