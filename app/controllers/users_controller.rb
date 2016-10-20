class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Created an account for #{@user.name}. Welcome!"
      redirect_to verify_path
    else
      flash.now[:error] = @user.errors.full_messages.join(". ")
      render new_user_path
    end
  end

  def show_verify
    #this is the page the user gets to enter his/her token
    @authy_verification = AuthyVerification.new(current_user)

  end

  def verify
    #the form from show verify button directs to this method
    #we get the token in the params here
    current_user.verify(token_params[:token])

    redirect_to dashboard_path
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
end
