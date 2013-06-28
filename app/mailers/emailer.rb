class Emailer < ActionMailer::Base
  default from: 'gratifiled@gmail.com'

  def send_document_email(document)
    @document = document
    mail( to: @document.recipient_email,
          subject: "#{@document.name} has shared a file with you!" )
  end

  def send_download_alert_email(document, access_time)
    @document = document
    @hours_left = @document.hours_to_expiration(access_time)
    mail( to: @document.email,
          subject: "#{@document.recipient_email} has downloaded your file!")
  end
end