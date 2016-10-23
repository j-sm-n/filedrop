class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show
    # raise ActionController::RoutingError.new('Not Found')
    render file: 'public/404', status: 404
  end
end
