class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password]) && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid. Try Again."
      render :new
    end
  end

  def destroy
    clear_tempfolder
    session.clear
    redirect_to root_path
  end

  private
    def clear_tempfolder
      if session[:downloaded_files]
        session[:downloaded_files].each do |file|
          File.delete(file)
        end
      end
    end
end
