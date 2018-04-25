class ApplicationMailer < ActionMailer::Base
  default from: 'info@rg_reviews.com'
  layout 'mailer'

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "RG Reviews password reset"
  end
end
