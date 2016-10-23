class DocumentsController < ApplicationController

  def new
    @document = Document.new
    @folders = current_user.folders
  end

end
