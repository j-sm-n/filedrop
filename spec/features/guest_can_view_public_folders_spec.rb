require 'rails_helper'

describe "Guest" do
  it "can view public folders" do
    folder = create :folder, name: 'Turing', permission_level: 1
    folder_2 = create :folder, name: 'Students', permission_level: 0

    visit root_path

    click_on "Public Files"

    expect(page).to have_content
  end
end
