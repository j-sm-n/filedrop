class Api::V1::CommentsController < ApplicationController
  before_action :api_key_valid?, only: [:create]

  def create
    document      = Document.find_by(id: params[:document_id])
    filedrop_user = User.find_by(id: params[:user_id])

    if document && filedrop_user
      document.comments.create(content: params[:content], user_id: params[:user_id])
      @cc = CommentCreation.new(document)
      render json: @cc
    else
      render json: { "error": "Required params are invalid" }, status: 404
    end
  end

  def index
    document = Document.find_by(id: params[:document_id])

    if document
      @ci = CommentIndex.new(document)
      render json: @ci
    else
      render json: { "error": "Required params are invalid" }, status: 404
    end
  end

  def show
    document = Document.find_by(id: params[:document_id])

    if document
      @cs = CommentShow.new(document, params[:id])
      render json: @cs
    else
      render json: { "error": "Required params are invalid" }, status: 404
    end
  end

  def update
    comment = Comment.find_by(id: params[:id])

    if comment
      comment.update_attributes(content: params[:comment])
      @cu = CommentUpdate.new(comment.id)

      render json: @cu
    else
      render json: { "error": "Required params are invalid" }, status: 404
    end
  end

  private

  def api_key_valid?
    registered_app = ExternalApplication.find_by(api_key: params[:api_key])

    render json: { "error": "Credentials are not valid" }, status: 404 unless registered_app
  end
end
