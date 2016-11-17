# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'xaxis-internal@xaxis-internal.herokuapp.com'
  layout 'mailer'
end
