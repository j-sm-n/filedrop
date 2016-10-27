require 'rails_helper'

describe CommentIndex do
  it "has the appropriate attributes" do
    document = create(:document)
    comment = create(:comment, content: "Yipee!",
                               document: document,
                               user: document.user)
    ci = CommentIndex.new(document)

    expect(ci.document_id).to eq(document.id)
    expect(ci.comments.class).to eq(Array)
    expect(ci.comments.first.class).to eq(Hash)
    expect(ci.comments.first[:comment][:content]).to eq("Yipee!")
    expect(ci.comments.first[:comment][:comment_id]).to eq(comment.id)
    expect(ci.comments.first[:comment][:user_id]).to eq(comment.user_id)
    expect(ci.count).to eq(1)
  end
end
