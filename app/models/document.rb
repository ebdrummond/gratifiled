class Document < ActiveRecord::Base
  attr_accessible :name, :email, :recipient_email, :message, :uuid, :document

  before_validation :add_uuid, on: :create
  validates_presence_of :name, :email, :recipient_email, :uuid
  validates_presence_of :document, message: " must be attached"

  has_attached_file :document

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

private
  def add_uuid
    self.uuid = UUID.new.generate
  end
end
