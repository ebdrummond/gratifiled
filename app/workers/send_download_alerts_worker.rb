class SendDownloadAlertsWorker
  include Sidekiq::Worker

  def perform(document_id)
    document = Document.find(document_id)
    access_time = Time.now.utc

    Emailer.send_download_alert_email(document, access_time).deliver
  end
end