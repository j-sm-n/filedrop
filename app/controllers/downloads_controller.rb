class DownloadsController < ApplicationController

  def new
    @folder = Folder.find(params[:id])
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

    zipfile_name = "tmp_dir/#{Time.now}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      files.each do |file|
        zipfile.add(file.filename, "tmp_dir/#{file.filename}")
      end
    end
    send_file zipfile_name
    record_file_sent(zipfile_name)
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

  def record_file_sent(zipfile_name)
    if session[:downloaded_files]
      session[:downloaded_files] << zipfile_name
    else
      session[:downloaded_files] = [zipfile_name]
    end
  end
end
