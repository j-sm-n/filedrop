class CommentCreation
  attr_reader :message,
              :document_id,
              :comment_id,
              :comment,
              :count

  def initialize(document)
    @message     = "A comment was created!"
    @document_id = document.id
    @comment_id  = document.comments.last.id
    @comment     = document.comments.last.content
    @count       = document.comments.count
  end
end
