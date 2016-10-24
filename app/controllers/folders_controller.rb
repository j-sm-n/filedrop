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

  # def download
  #   files_to_download = params[:document][:file]
  #   file_name = params[:document][:file].original_filename
  #   bucket = S3.bucket(S3_BUCKET.name)
  #
  # end
end
