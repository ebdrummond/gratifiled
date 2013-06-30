class SendEmailsWorker
  include Sidekiq::Worker

  def perform(fileshare_id)
    fileshare = Fileshare.find(fileshare_id)

    Emailer.send_fileshare_email(fileshare).deliver
  end
end