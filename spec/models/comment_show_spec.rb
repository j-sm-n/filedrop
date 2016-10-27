require 'rails_helper'

describe CommentShow do
  it "has the appropriate attributes" do
    document = create(:document)
    comment = create(:comment, content: "Yipee!",
                               document: document,
                               user: document.user)
    cs = CommentShow.new(document, comment)

    expect(cs.document_id).to eq(document.id)
    expect(cs.comment).to eq("Yipee!")
    expect(cs.comment_id).to eq(comment.id)
    expect(cs.user_id).to eq(comment.user_id)
  end
end
