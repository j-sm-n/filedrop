class ApiNotifierMailer < ApplicationMailer
  def send_api(application, applicant_email)
    @application = application
    mail(to: applicant_email, subject: "Your requested credentials from FileDrop.")
  end
end
