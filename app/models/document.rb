class Document < ActiveRecord::Base
  attr_accessible :name, :email, :recipient_email, :message, :uuid

  before_validation :add_uuid, on: :create
  validates_presence_of :name, :email, :recipient_email, :uuid

  def expiration
    created_at + 3.days
  end

  def formatted_expiration
    local_time = expiration.to_time.localtime
    local_time.strftime("%B %-d at %-l:%M %P")
  end

private
  def add_uuid
    self.uuid = UUID.new.generate
  end
end
