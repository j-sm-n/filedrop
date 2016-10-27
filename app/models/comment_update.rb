class CommentUpdate
  attr_reader :comment,
              :user_id,
              :comment_id

  def initialize(comment_id)
    @user_id     = Comment.find(comment_id).user_id
    @comment     = Comment.find(comment_id).content
    @comment_id  = Comment.find(comment_id).id
  end

end
