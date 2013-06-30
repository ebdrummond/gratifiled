class Emailer < ActionMailer::Base
  default from: 'gratifiled@gmail.com'

  def send_fileshare_email(fileshare)
    @fileshare = fileshare
    mail( to: @fileshare.recipient_email,
          subject: "#{@fileshare.name} has shared a file with you!" )
  end

  def send_download_alert_email(fileshare, access_time)
    @fileshare = fileshare
    @hours_left = @fileshare.hours_to_expiration(access_time)
    mail( to: @fileshare.email,
          subject: "#{@fileshare.recipient_email} has downloaded your file!")
  end
end