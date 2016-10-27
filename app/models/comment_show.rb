class CommentShow
  attr_reader :comment,
              :document_id,
              :user_id,
              :comment_id

  def initialize(document, comment_id)
    @document_id = document.id
    @user_id     = Comment.find(comment_id).user_id
    @comment     = Comment.find(comment_id).content
    @comment_id  = Comment.find(comment_id).id
  end

end
