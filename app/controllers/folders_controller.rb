class FoldersController < ApplicationController
  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      flash[:success] = "#{@folder.name} was added"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private
    def folder_params
      params.require(:folder).permit(:name)
    end

end
