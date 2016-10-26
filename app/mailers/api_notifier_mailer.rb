class ApiNotifierMailer < ApplicationMailer
  def send_api(user, applicant)
    @user = user
    mail(to: applicant, subject: "Your requested credentials from FileDrop.")
  end
end
