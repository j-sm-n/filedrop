class Admin::AdminController < ApplicationController
  before_action :authorized?

  def authorized?
    render file: 'public/404', status: 404 unless current_admin?
  end
end
