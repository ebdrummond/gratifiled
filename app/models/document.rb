class Document < ActiveRecord::Base
  attr_accessible :document, :expired, :downloaded

  validates :document, presence: {:on => :create}

  has_attached_file :document

  belongs_to :fileshare

end