require 'rails_helper'

describe "Comments CRUD API" do
  it "creates a comment" do
    user = create(:user)
    folder = create(:folder, user: user)
    document = create(:document, folder: folder, user: user)
    application = create(:external_application, user: user)

    expect do
      post "/api/v1/comments?api_key=7&document_id=#{document.id}&user_id=#{user.id}&content=Yippee!"
    end.to change { Comment.count }.from(0).to(1)

    raw_comment = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(raw_comment[:message]).to eq("A comment was created!")
    expect(raw_comment[:document_id]).to eq(document.id)
    expect(raw_comment[:comment_id]).to eq(document.comments.last.id)
    expect(raw_comment[:count]).to eq(1)
    expect(Comment.last.content).to eq("Yippee!")
  end
end
