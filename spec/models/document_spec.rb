require 'spec_helper'

describe Document do
  let(:fileshare) {stub(id: 1)}
  let(:document) {Document.new(document: File.new('spec/fixtures/lola_may.png'),
                               fileshare_id: fileshare.id)}

  it "requires a document" do
    expect{ document.document = nil }.to change { document.valid? }.to be_false
  end

  it "has a default downloaded state of false" do
    expect(document.downloaded).to eq(false)
  end

  it "has a default expired state of false" do
    expect(document.expired).to eq(false)
  end

  describe "#download_sequence" do
    it "changes the download status from false to true" do
      document.download_sequence
      expect(document.downloaded).to eq(true)
    end
  end

  describe ".active_documents" do
    it "returns all active documents" do
      document.expired = true
      document.save
      Document.create(document: File.new('spec/fixtures/lola_may.png'),
                      fileshare_id: fileshare.id)
      expect(Document.active_documents.count).to eq(1)
    end
  end

  describe ".set_to_expire" do
    it "returns the active documents that are ready to be expired" do
      document.created_at = Time.now.utc - 4.days
      document.save
      expect(Document.set_to_expire).to include(document)
    end
  end
end
