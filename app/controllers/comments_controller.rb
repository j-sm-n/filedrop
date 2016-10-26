class CommentsController < ApplicationController
  def create
    @comment = Document.find(comment_params[:document])
                       .comments.new(user_id: current_user.id,
                                     content: comment_params[:content])

    if @comment.save
      flash[:success] = "Your comment was posted!"
      redirect_to user_document_path(params[:user_id],
                                     comment_params[:document])
    else
      flash[:warning] = "Comment field can't be empty"
      redirect_to user_document_path(params[:user_id],
                                     comment_params[:document])
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    redirect_to user_document_path(params[:user_id], params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :document)
  end
end
