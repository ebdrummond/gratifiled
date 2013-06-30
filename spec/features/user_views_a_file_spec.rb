require 'spec_helper'

describe "user views a file" do
  let!(:document) {Document.create(document: File.new('spec/fixtures/lola_may.png'))}
  let!(:fileshare) {Fileshare.create(sender_name: "erin",
                                     sender_email: "erin@example.com",
                                     recipient_email: "brock@example.com",
                                     message: "the dog ate my homework",
                                     documents: [document])}

  context "when attempting to view an active fileshare" do
    it "displays the fileshare information" do
      fileshare.created_at = DateTime.new(2013, 6, 25, 10)
      fileshare.save
      visit fileshare_path(fileshare.uuid)
      expect(page).to have_content("the dog ate my homework")
      expect(page).to have_content("June 28 at 4:00 am")
      expect(page).to have_content("lola_may.png")
      expect(page).to have_content("570.405 KB")
      expect(page).to have_link("Download file")
    end
  end

  context "when attempting to view an expired fileshare" do
    it "displays an error" do
      doc = fileshare.documents.first
      doc.expired = true
      doc.save
      visit fileshare_path(fileshare.uuid)
      expect(page).to have_content("We're sorry, but this file has now expired.")
    end
  end
end