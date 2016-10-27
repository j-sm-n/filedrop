class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show
    @folder = Folder.find(params[:id])
    @documents = @folder.documents
    unless @folder.accessible?(current_user)
      render file: 'public/404', status: 404
    end
  end

  def update
    @user = User.find_by(email: params[:folder][:folder_permissions])
    @folder = Folder.find(params[:id])
    @folder.authorized_users << @user
    flash[:success] = "#{@user.name} has been granted access!"
    redirect_to dashboard_path
  end
end
