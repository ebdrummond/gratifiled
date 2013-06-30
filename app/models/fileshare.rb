class Fileshare < ActiveRecord::Base
  attr_accessible :sender_name, :sender_email, :recipient_email, :message, :uuid, :documents_attributes

  before_validation :add_uuid, on: :create
  validates_presence_of :sender_name, :sender_email, :recipient_email, :uuid
  #validates :document, presence: {:on => :create}

  has_many :documents
  accepts_nested_attributes_for :documents

  def expiration
    created_at + 3.days
  end

  def formatted_expiration
    local_time = expiration.to_time.localtime
    local_time.strftime("%B %-d at %-l:%M %P")
  end

  def hours_to_expiration(access_time)
    seconds_to_expiration = expiration.to_time - access_time
    (seconds_to_expiration / 3600).round(1)
  end

  def download_sequence
    if !downloaded
      SendDownloadAlertsWorker.perform_async(id)
      self.downloaded = true
      save
    end
  end

  def self.active_documents
    Fileshare.where(expired: false)
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

private
  def add_uuid
    self.uuid = UUID.new.generate
  end
end
