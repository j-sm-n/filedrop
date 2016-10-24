class UsersController < ApplicationController
  before_action :check_authy_id, only: [:show_verify, :verify]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.create_authy_user
      session[:user_id] = @user.id
      flash[:success] = "Created an account for #{@user.name}. Welcome!"
      redirect_to verify_path
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
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.join('. ')
      render :edit
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
end
