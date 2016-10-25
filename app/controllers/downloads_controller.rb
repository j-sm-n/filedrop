class DownloadsController < ApplicationController

  def new
    @folder = Folder.find(params[:id])
    # @document = Document.where(filename: params[:filename], parent_id: params[:id])
    @documents = @folder.documents
  end

  def create
    bucket = S3.bucket(S3_BUCKET.name)
    files = file_ids_to_download.map do |id|
      Document.find(id)
    end
    files.each do |file|
      file_obj = bucket.object("#{file.amazon_path}/#{file.filename}")
      file_obj.get(response_target: "tmp_dir/#{file.filename}")
    end
    zipfile_name = Time.now
    Zip::File.open("tmp_dir/#{zipfile_name}.zip", Zip::File::CREATE) do |zipfile|
      files.each do |file|
        zipfile.add(file.filename, "tmp_dir/#{file.filename}")
      end
    end
    send_file "tmp_dir/#{zipfile_name}.zip"
    File.delete("./tmp_dir/.zip")
  end

  private

  def document_params
    params.require(:document).permit(:id, :file)
  end

  def filepath
    params[:user_id] + "/" + params[:document][:parent] + "/" + document_params[:file].original_filename
  end

  def user_params
    params.require(:user_id)
  end

  def parent_folder
    params.require(:document).permit(:parent)
  end

  def file_ids_to_download
    files = []
    params[:download].to_a.map do |key, value|
      if value == "1"
        files << key
      end
    end
    return files.flatten
  end

end
