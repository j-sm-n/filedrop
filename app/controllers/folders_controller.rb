class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show

  end
end
