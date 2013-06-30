class Document < ActiveRecord::Base
  attr_accessible :document, :expired, :downloaded, :fileshare_id
  validates :document, presence: {:on => :create}
  has_attached_file :document
  belongs_to :fileshare

  def self.active_documents
    Document.where(expired: false)
  end

  def self.set_to_expire
    active_documents.where(["created_at < ?", (Time.now.utc - 3.days)])
  end

  def self.clear_expired_files
    set_to_expire.to_a.each do |document|
      document.expired = true
      document.document = nil
      document.save
    end
  end

  def download_sequence
    if !downloaded
      SendDownloadAlertsWorker.perform_async(id)
      self.downloaded = true
      save
    end
  end
end