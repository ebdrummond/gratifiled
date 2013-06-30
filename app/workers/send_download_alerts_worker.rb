class SendDownloadAlertsWorker
  include Sidekiq::Worker

  def perform(fileshare_id)
    fileshare = Fileshare.find(fileshare_id)
    access_time = Time.now.utc

    Emailer.send_download_alert_email(fileshare, access_time).deliver
  end
end