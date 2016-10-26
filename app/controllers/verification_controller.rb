class VerificationController < ApplicationController
  before_action :check_authy_id
  
  def new
    service = TwilioService.new(current_user)
    service.generate_code
    @authy_verification = AuthyVerification.new(current_user)
  end

  def create
    response = current_user.verify(token_params[:token])
    if response[:success]
      redirect_to dashboard_path
    else
      flash[:error] = "Code was not recognized"
      redirect_to verify_path
    end
  end

  private
    def token_params
      params.require(:authy_verification).permit(:token)
    end

    def check_authy_id
      unless current_user && current_user.authy_id
        redirect_to new_user_path
      end
    end
end
