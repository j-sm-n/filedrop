require 'rails_helper'

RSpec.describe Folder, type: :model do
  it 'destroys child folders when destroyed' do
    user = create :user
    root = user.folders.first
    root.subfolders.create(name: 'Test', user: user)
    expect { root.destroy }.to change { Folder.count }.by(-2)
  end

  it 'destroys items when destroyed' do
    user = create :user
    root = user.folders.first
    root.documents.create(filename: 'test', user: user)
byebug
    expect { root.destroy }.to change { Document.count }.by(-1)
  end
end
