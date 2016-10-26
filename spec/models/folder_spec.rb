require 'rails_helper'

RSpec.describe Folder, type: :model do
  it 'destroys child folders when destroyed' do
    user = create :user
    root = user.folders.first
    root.subfolders.create(name: 'Test', user: root.user)

    expect { root.destroy }.to change { Folder.count }.by(-2)
  end
end
