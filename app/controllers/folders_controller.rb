class FoldersController < ApplicationController
  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      if parent_folder[:id]
        Folder.find(parent_folder[:id]).subfolders << @folder
        flash[:success] = "#{@folder.name} was added to #{Folder.find(parent_folder[:id]).name}"
      else
        flash[:success] = "#{@folder.name} was added"
      end
      redirect_to dashboard_path
    else
      flash.now[:error] = @folder.errors.full_messages.join('. ')
      render :new
    end
  end

  private
    def folder_params
      params.require(:folder).permit(:name)
    end

    def parent_folder
      params.require(:folder).permit(:id)
    end
end
