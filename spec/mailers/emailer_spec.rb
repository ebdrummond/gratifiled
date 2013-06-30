require 'spec_helper'

describe Emailer do
  describe "#send_fileshare_email" do
    let!(:document) {Document.create(document: File.new('spec/fixtures/lola_may.png'))}
    let!(:fileshare) {Fileshare.create(sender_name: "erin",
                                       sender_email: "erin@example.com",
                                       recipient_email: "brock@example.com",
                                       message: "the dog ate my homework",
                                       documents: [document])}
    let!(:worker) {SendEmailsWorker.new}
    let!(:mail) {Emailer.send_fileshare_email(fileshare)}

    it "renders the headers" do
      mail.subject.should eq("erin has shared a file with you!")
      mail.to.should eq(["brock@example.com"])
      mail.from.should eq(["gratifiled@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include(fileshare.formatted_expiration)
    end
  end

  describe "#send_download_alert_email" do
    let!(:document) {Document.create(document: File.new('spec/fixtures/lola_may.png'))}
    let!(:fileshare) {Fileshare.create(sender_name: "erin",
                                       sender_email: "erin@example.com",
                                       recipient_email: "brock@example.com",
                                       message: "the dog ate my homework",
                                       documents: [document])}
    let!(:worker) {SendDownloadAlertsWorker.new}
    let!(:access_time) {Time.new(2013, 6, 27, 4).utc}
    let!(:mail) {Emailer.send_download_alert_email(document, access_time)}

    it "renders the headers" do
      mail.subject.should eq("brock@example.com has downloaded your file!")
      mail.to.should eq(["erin@example.com"])
      mail.from.should eq(["gratifiled@gmail.com"])
    end

    it "renders the body" do
      mail.body.should include("lola_may.png")
    end
  end
end