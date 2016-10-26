class Api::V1::CommentsController < ApplicationController
  def create
    document = Document.find(params[:document_id])
    document.comments.create(content: params[:content], user_id: params[:user_id])

    @cc = CommentCreation.new(document)
    render json: @cc
  end
end
