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
end
