class Emailer < ActionMailer::Base
  default from: 'gratifiled@gmail.com'

  def send_document_email(document)
    @document = document
    mail( to: @document.recipient_email,
          subject: "#{@document.name} has shared a file with you!" )
  end
end