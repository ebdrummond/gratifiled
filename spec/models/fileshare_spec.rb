require 'spec_helper'

describe Fileshare do
  let!(:document) {Document.new(document: File.new('spec/fixtures/lola_may.png'))}
  let!(:fileshare) {Fileshare.new(sender_name: "erin",
                                 sender_email: "erin@example.com",
                                 recipient_email: "brock@example.com",
                                 message: "the dog ate my homework",
                                 documents: [document])}

  it "requires a name" do
    expect{ fileshare.sender_name = "" }.to change { fileshare.valid? }.to be_false
  end

  it "requires an email" do
    expect{ fileshare.sender_email = "" }.to change { fileshare.valid? }.to be_false
  end

  it "requires a recipient email" do
    expect{ fileshare.recipient_email = "" }.to change { fileshare.valid? }.to be_false
  end

  it "requires a uuid hash" do
    fileshare.save
    expect{ fileshare.uuid = nil }.to change { fileshare.valid? }.to be_false
  end

  it "does not require a message" do
    fileshare.message = ""
    expect(fileshare).to be_valid
  end

  describe "#expiration" do
    it "has an expiration of 72 hours after the fileshare was created" do
      fileshare.created_at = DateTime.new(2013, 6, 25, 10)
      expect(fileshare.expiration).to eq(DateTime.new(2013, 6, 28, 10))
    end
  end

  describe "#hours_to_expiration" do
    it "returns the hours to expiration" do
      fileshare.created_at = DateTime.new(2013, 6, 25, 10).to_time
      fileshare.save
      access_time = Time.new(2013, 6, 27, 4).utc
      expect(fileshare.hours_to_expiration(access_time)).to eq(24)
    end
  end

  describe ".active_documents" do
    it "returns true or false if a given document is active" do
      document.expired = true
      document.save
      fileshare.save
      Document.create(document: File.new('spec/fixtures/lola_may.png'),
                      fileshare_id: fileshare.id)
      expect(fileshare.active_documents.count).to eq(1)
    end
  end

  describe "#active" do
    it "returns active if any associated documents are active" do
      document.expired = true
      document.save
      fileshare.save
      Document.create(document: File.new('spec/fixtures/lola_may.png'),
                      fileshare_id: fileshare.id)
      expect(fileshare.active?).to eq(true)
    end
  end
end
