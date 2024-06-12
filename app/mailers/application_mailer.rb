class ApplicationMailer < ActionMailer::Base
  default from:     "beanpediacoffee事務局",
          cc:       "beanpediacoffee@gmail"
  layout 'mailer'
end
