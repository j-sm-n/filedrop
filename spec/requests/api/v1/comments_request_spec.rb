require 'rails_helper'

describe "Comments CRUD API" do
  it "creates a comment" do
    user        = create(:user)
    folder      = create(:folder, user: user)
    document    = create(:document, folder: folder, user: user)
    application = create(:external_application, user: user)

    expect do
      post "/api/v1/comments?api_key=7&document_id=#{document.id}&user_id=#{user.id}&content=Yippee!"
    end.to change { Comment.count }.from(0).to(1)

    raw_comment = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(raw_comment[:message]).to eq("A comment was created!")
    expect(raw_comment[:comment]).to eq("Yippee!")
    expect(raw_comment[:document_id]).to eq(document.id)
    expect(raw_comment[:comment_id]).to eq(document.comments.last.id)
    expect(raw_comment[:count]).to eq(1)
    expect(Comment.last.content).to eq("Yippee!")
  end

  context "bad api key" do
    it "has a useful error message" do
      user        = create(:user)
      folder      = create(:folder, user: user)
      document    = create(:document, folder: folder, user: user)
      application = create(:external_application, user: user)

      post "/api/v1/comments?api_key=000&document_id=#{document.id}&user_id=#{user.id}&content=Yippee!"

      raw_resp = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(raw_resp[:error]).to eq("Credentials are not valid")
    end
  end

  context "Missing required params" do
    it "is missing document id being posted to" do
      user        = create(:user)
      folder      = create(:folder, user: user)
      document    = create(:document, folder: folder, user: user)
      application = create(:external_application, user: user)

      post "/api/v1/comments?api_key=7&document_id=&user_id=#{user.id}&content=Yippee!"

      raw_resp = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(raw_resp[:error]).to eq("Required params are invalid")
    end
  end

  it "shows all comments" do
    user        = create(:user)
    folder      = create(:folder, user: user)
    document    = create(:document, folder: folder, user: user)
    comment_1   = create(:comment, content: "This is comment 1", user: user, document: document, created_at: "12/20/2009 00:00")
    comment_2   = create(:comment, content: "This is comment 2", user: user, document: document, created_at: "12/20/2011 00:00")
    comment_3   = create(:comment, content: "This is comment 3", user: user, document: document, created_at: "12/20/2012 00:00")
    application = create(:external_application, user: user)

    get "/api/v1/comments?api_key=7&document_id=#{document.id}"

    raw_resp = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(raw_resp[:document_id]).to eq(document.id)
    expect(raw_resp[:count]).to eq(3)
    expect(raw_resp[:comments].class).to eq(Array)

    expect(raw_resp[:comments][0][:comment][:content]).to eq("This is comment 1")
    expect(raw_resp[:comments][0][:comment][:user_id]).to eq(user.id)
    expect(raw_resp[:comments][0][:comment][:comment_id]).to eq(comment_1.id)

    expect(raw_resp[:comments][2][:comment][:content]).to eq("This is comment 3")
    expect(raw_resp[:comments][2][:comment][:comment_id]).to eq(comment_3.id)
  end

  context "Missing required params" do
    it "is missing document id for get index" do
      user        = create(:user)
      folder      = create(:folder, user: user)
      document    = create(:document, folder: folder, user: user)
      create(:comment, content: "This is comment 1", user: user, document: document, created_at: "12/20/2009 00:00")
      application = create(:external_application, user: user)

      get "/api/v1/comments?api_key=7&document_id="

      raw_resp = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(raw_resp[:error]).to eq("Required params are invalid")
    end
  end

  it "shows a single comment" do
    user        = create(:user)
    folder      = create(:folder, user: user)
    document    = create(:document, folder: folder, user: user)
    comment_1   = create(:comment, content: "This is comment 1",
                                   user: user,
                                   document: document)
    application = create(:external_application, user: user)

    get "/api/v1/comments/#{comment_1.id}?api_key=7&document_id=#{document.id}"

    raw_resp = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(raw_resp[:document_id]).to eq(document.id)
    expect(raw_resp[:comment]).to eq(comment_1.content)
    expect(raw_resp[:user_id]).to eq(user.id)
  end

  it "upates the content of a single comment" do
    user        = create(:user)
    folder      = create(:folder, user: user)
    document    = create(:document, folder: folder, user: user)
    comment_1   = create(:comment, content: "This is comment 1",
                                   user: user,
                                   document: document)
    application = create(:external_application, user: user)

    patch "/api/v1/comments/#{comment_1.id}?api_key=7&document_id=#{document.id}&comment=BOOM"

    raw_resp = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(raw_resp[:comment]).to eq("BOOM")
    expect(raw_resp[:user_id]).to eq(user.id)
    expect(raw_resp[:comment_id]).to eq(comment_1.id)
  end
end
