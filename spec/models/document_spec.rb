require 'spec_helper'

describe Document do
  let(:document) {Document.new(name: "erin",
                               email: "erin@example.com",
                               recipient_email: "brock@example.com",
                               message: "the dog ate my homework",
                               document: File.new('spec/fixtures/lola_may.png'))}

  it "requires a name" do
    expect{ document.name = "" }.to change { document.valid? }.to be_false
  end

  it "requires an email" do
    expect{ document.email = "" }.to change { document.valid? }.to be_false
  end

  it "requires a recipient email" do
    expect{ document.recipient_email = "" }.to change { document.valid? }.to be_false
  end

  it "requires a uuid hash" do
    document.save
    expect{ document.uuid = nil }.to change { document.valid? }.to be_false
  end

  it "does not require a message" do
    document.message = ""
    expect(document).to be_valid
  end

  it "has a default downloaded state of false" do
    expect(document.downloaded).to eq(false)
  end

  describe "#expiration" do
    it "has an expiration of 72 hours after the document was created" do
      document.created_at = DateTime.new(2013, 6, 25, 10)
      expect(document.expiration).to eq(DateTime.new(2013, 6, 28, 10))
    end
  end

  describe "#hours_to_expiration" do
    it "returns the hours to expiration, rounded one decimal place" do
      document.created_at = DateTime.new(2013, 6, 25, 10).to_time
      document.save
      access_time = Time.new(2013, 6, 27, 4).utc
      expect(document.hours_to_expiration(access_time)).to eq(24.0)
    end
  end

  describe "#download_sequence" do
    it "changes the download status from false to true" do
      document.download_sequence
      expect(document.downloaded).to eq(true)
    end
  end

  describe ".active_documents" do
    it "defines the files that have been created within the last 72 hours" do
      document.save
      document2 = Document.create(name: "erin",
                                  email: "erin@example.com",
                                  recipient_email: "brock@example.com",
                                  message: "the dog ate my homework",
                                  document: File.new('spec/fixtures/lola_may.png'))
      document2.created_at = (Time.now.utc - 4.days)
      document2.save
      expect(Document.active_documents).to eq([document])
    end
  end
end
