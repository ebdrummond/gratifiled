class Emailer < ActionMailer::Base
  default from: 'gratifiled@gmail.com'

  def send_fileshare_email(fileshare)
    @fileshare = fileshare
    mail( to: @fileshare.recipient_email,
          subject: "#{@fileshare.sender_name} has shared a file with you!" )
  end

  def send_download_alert_email(document, access_time)
    @document = document
    @fileshare = document.fileshare
    @hours_left = @document.fileshare.hours_to_expiration(access_time)
    mail( to: @fileshare.sender_email,
          subject: "#{@fileshare.recipient_email} has downloaded your file!")
  end
end