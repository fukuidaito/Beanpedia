class WelcomeMailer < ApplicationMailer

  def send_when_signup(email, name)
    @name = name
    mail(to: email, subject: 'Welcome to Our Service')
  end
end
