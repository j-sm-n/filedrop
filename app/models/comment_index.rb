class CommentIndex
  attr_reader :comments,
              :document_id,
              :count

  def initialize(document)
    @document_id = document.id
    @count       = document.comments.count
    @comments = build_comments(document.comments)
  end

  def build_comments(comments)
    comments.map do |comment|
      { "comment": { "comment_id": comment.id, "content": comment.content, "user_id": comment.user_id, "created_at": comment.created_at } }
    end
  end
end
