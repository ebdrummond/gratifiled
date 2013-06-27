require 'spec_helper'

describe Emailer do
  describe "#send_document_email" do
    let!(:document) {Document.create(name: "erin",
                                    email: "erin@sample.com",
                                    recipient_email: "brock@sample.com",
                                    document: File.new('spec/fixtures/lola_may.png'))}
    let!(:worker) {SendEmailsWorker.new}
    let!(:mail) {Emailer.send_document_email(document)}

    xit "receives the information from the Send Emails Worker" do
      Emailer.should_receive(:send_document_email).with(document)
      worker.perform(document.id)
    end

    it "renders the headers" do
      mail.subject.should eq("erin has shared a file with you!")
      mail.to.should eq(["brock@sample.com"])
      mail.from.should eq(["gratifiled@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include(document.formatted_expiration)
    end
  end
end