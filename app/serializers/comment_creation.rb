class CommentCreation < ActiveModel::Serializer
  attributes :message, :document_id, :comment_id, :count

end
