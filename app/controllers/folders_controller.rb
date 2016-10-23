class FoldersController < ApplicationController

  def index
    @folders = Folder.unrestricted_folders
  end

  def show
    @folder = Folder.find(params[:id])
    @documents = @folder.documents

    if @folder.authorized_users.include?(current_user)
    else
    # raise ActionController::RoutingError.new('Not Found')
      render file: 'public/404', status: 404
    end
  end
end
