class FoldersController < ApplicationController
  def new
    @folder = Folder.new
  end

  def create
    current_user.folders.new(folder_params)
  end
end
