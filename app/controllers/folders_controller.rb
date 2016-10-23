class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show
    @folder = Folder.find(params[:id])
    @documents = @folder.documents
  end
end
