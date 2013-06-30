class Fileshare < ActiveRecord::Base
  attr_accessible :sender_name, :sender_email, :recipient_email, :message, :uuid, :documents_attributes, :documents
  before_validation :add_uuid, on: :create
  validates_presence_of :sender_name, :sender_email, :recipient_email, :uuid
  has_many :documents
  validates :documents, presence: {:on => :create}
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
    (seconds_to_expiration / 3600).to_i
  end

  def active_documents
    documents.where(expired: false)
  end

  def active?
    documents.pluck(:expired).include?(false)
  end

private
  def add_uuid
    self.uuid = UUID.new.generate
  end
end
