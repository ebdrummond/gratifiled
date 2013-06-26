class SendEmailsWorker
  include Sidekiq::Worker

  def perform(document_id)
    document = Document.find(document_id)

    Emailer.send_document_email(document).deliver
  end
end