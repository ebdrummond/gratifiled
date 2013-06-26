class Document < ActiveRecord::Base
  attr_accessible :name, :email, :recipient_email, :message

  validates_presence_of :name, :email, :recipient_email

  def expiration
    self.created_at + 3.days
  end
end
