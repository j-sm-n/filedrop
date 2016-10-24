class DocumentsController < ApplicationController

  def new
    @document = Document.new
    @folders = current_user.folders
  end

  def create
    file_to_upload = params[:document][:file]
    file_name = params[:document][:file].original_filename
    bucket = S3.bucket(S3_BUCKET.name)

    obj = bucket.object(file_name)

    obj.put(
      acl: "public-read",
      body: file_to_upload
    )
    
    @document = Document.new(user_id: user_params, filename: document_params[:file].original_filename, content_type: document_params[:file].content_type, url: obj.public_url)

    if @document.save
      flash[:success] = @document.set_parent(parent_folder[:parent])
      redirect_to folder_path(parent_folder[:parent])
    else
      flash.new[:notice] = 'There was an error'
      render :new
    end
  end

  private

  def document_params
    params.require(:document).permit(:id, :file)
  end

  def user_params
    params.require(:user_id)
  end

  def parent_folder
    params.require(:document).permit(:parent)
  end
end
