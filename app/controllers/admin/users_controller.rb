class Admin::UsersController < Admin::AdminController
  def index
    @users = User.non_admin_users
  end

  def update
    if User.find(params[:id]).toggle_status?
      flash[:success] = "User status has been updated!"
    else
      flash[:error] = "Please try again, user status was not updated."
    end
    redirect_to admin_users_path
  end
end
