class Users::FoldersController < ApplicationController
  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      flash[:success] = @folder.set_parent(parent_folder[:id])
      redirect_to dashboard_path
    else
      flash.now[:error] = @folder.errors.full_messages.join('. ')
      render :new
    end
  end

  def index
    @folders = User.find(params[:user_id]).folders.unrestricted_folders
  end

  private
    def folder_params
      params.require(:folder).permit(:name, :permission_level)
    end

    def parent_folder
      params.require(:folder).permit(:id)
    end


end
