class FeedbackNotifierMailer < ApplicationMailer
  default :from => 'xaxis-internal@xaxis.com'

  def send_feedback_form(contact)
    @contact = contact
    mail( :to => 'troy.starwalt@xaxis.com', :subject => 'New Feedback From Xaxis Internal')
  end
end
