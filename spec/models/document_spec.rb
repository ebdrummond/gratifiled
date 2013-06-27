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

  describe "#expiration" do
    it "has an expiration of 72 hours after the document was created" do
      document.created_at = DateTime.new(2013, 6, 25, 10)
      expect(document.expiration).to eq(DateTime.new(2013, 6, 28, 10))
    end
  end
end
