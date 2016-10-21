class UsersController < ApplicationController
  before_action :check_authy_id, only: [:show_verify, :verify]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      service = TwilioService.new(@user)
      response = service.get_authy_user
      if response[:success]
        @user.update_attribute(:authy_id, response[:user][:id])
        # byebug
        session[:user_id] = @user.id
        flash[:success] = "Created an account for #{@user.name}. Welcome!"
        redirect_to verify_path
      end
    else
      flash.now[:error] = @user.errors.full_messages.join(". ")
      render new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = 'Your account has been updated'
      redirect_to dashboard_path
    else
      flash.now[:error] = 'Please make sure fields are updated correctly'
      render :edit
    end
  end

  def show_verify
    #this is the page the user gets to enter his/her token
    service = TwilioService.new(current_user)
    service.generate_code
    @authy_verification = AuthyVerification.new(current_user)
  end

  def verify
    #the form from show verify button directs to this method
    #we get the token in the params here
    response = current_user.verify(token_params[:token])
    if response[:success]
      redirect_to dashboard_path
    else
      flash[:error] = "Code was not recognized"
      redirect_to verify_path
    end
  end

  def show
  end

  private
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :sms_number,
        :password,
        :password_confirmation
      )
    end

    def token_params
      params.require(:authy_verification).permit(:token)
    end

    def check_authy_id
      unless current_user && current_user.authy_id
        redirect_to new_user_path
      end
    end
end
