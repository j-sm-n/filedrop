class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show
    @folder = Folder.find(params[:id])
    unless @folder.accessable?(current_user)
      render file: 'public/404', status: 404
    end
  end
end
