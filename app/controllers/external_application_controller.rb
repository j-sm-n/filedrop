class ExternalApplicationController < ApplicationController
  def index
    @applications = current_user.external_applications
  end
end
