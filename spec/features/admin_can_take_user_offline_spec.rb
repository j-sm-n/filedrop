require 'rails_helper'

describe 'Admin dashboard' do
  it 'gives admin functionality to take user offline' do
    user = create :user, name: 'Chad', email: 'chad@example.com'
    admin = create :user, role: 1

    # -As a platform admin who is logged in
    login(admin)
    # -When I click on dashboard
    visit admin_dashboard_path
    # -Then I should be on admin/dashboard
    expect(current_path).to eq(admin_dashboard_path)
    # -And I should see a link to view all users
    click_on 'All Users'
    # -And when I click "View All Users"
    # -Then I should be on /all_users
    expect(current_path).to eq('/admin/users')
    # -Then I should see a list of all users with a description of their status and with links to -activate or deactivate each user
    expect(page).to have_content('Chad')
    expect(page).to have_content('Active')
    expect(page).to_not have_content('Deactivated')
    expect(page).to_not have_link('Activate')
    expect(page).to have_link('Deactivate')
    # -And users who are active should only have the link to deactivate
    # -And when I click "Deactivate" on an active user
    click_on 'Deactivate'
    # -Then I should see a message stating that the user (and the user's content) has been deactivated
    expect(page).to have_content('Deactivated')
    expect(page).to_not have_content('Active')
    expect(page).to_not have_link('Deactivate')
    expect(page).to have_link('Activate')
    # -And users who are inactive should only have the link to activate
    # -And when I click "Activate" on a deactivated user
    click_on 'Activate'
    # -Then I should see a message stating that the user (and the user's content) has been activated
    expect(page).to have_content('Active')
    expect(page).to_not have_content('Deactivated')
    expect(page).to_not have_link('Activate')
    expect(page).to have_link('Deactivate')

    # -Then I should be sent back to /all_users
    # -And I should see a list of all users with their status updated
    expect(current_path).to eq('/admin/users')
    expect(page).to have_content('Chad')
  end

  it 'blocks access from guest and registered users' do
    # As a guest
    # When I visit admin path
    # I should see 404s
    visit admin_dashboard_path

    expect(page.status_code).to eq(404)


    visit admin_users_path

    expect(page.status_code).to eq(404)

  end
end
