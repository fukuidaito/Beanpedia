require 'rails_helper'

RSpec.describe WelcomeMailer, type: :mailer do
  describe 'send_when_signup' do
    let(:mail) { WelcomeMailer.send_when_signup }
  end
end
