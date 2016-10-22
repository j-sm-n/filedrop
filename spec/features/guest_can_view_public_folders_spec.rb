require 'rails_helper'

describe "Guest" do
  it "can view public folders" do
    user = create :user
    folder = create :folder, user_id: user.id, name: 'Turing', permission_level: 1
    folder_2 = create :folder, user_id: user.id, name: 'Students', permission_level: 0

    visit root_path

    click_on "Public Files"

    expect(current_path).to eq(folders_path)
    expect(page).to have_content('Turing')
    expect(page).to_not have_content('Students')
  end
end
