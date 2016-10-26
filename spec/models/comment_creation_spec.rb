require 'rails_helper'

describe CommentCreation do
  it "has the appropriate attributes" do
    document = create(:document)
    comment = create(:comment, content: "Yipee!",
                               document: document,
                               user: document.user)
    cc = CommentCreation.new(document)

    expect(cc.message).to eq("A comment was created!")
    expect(cc.document_id).to eq(document.id)
    expect(cc.comment_id).to eq(comment.id)
    expect(cc.count).to eq(1)
  end
end
