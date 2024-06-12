class WelcomeMailer < ApplicationMailer
  def send_when_signup(email, name)
    @name = name
    mail(to: email, subject: I18n.t('welcome_mailer.send_when_signup.subject'))
  end
end
