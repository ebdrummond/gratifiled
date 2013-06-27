require 'spec_helper'

describe "user views a file" do
  let!(:document) {Document.create(name: "erin",
                                   email: "erin@sample.com",
                                   recipient_email: "brock@sample.com",
                                   document: File.new('spec/fixtures/lola_may.png'))}

  it "displays the document information" do
    document.created_at = DateTime.new(2013, 6, 25, 10)
    document.save
    visit document_path(document.uuid)
    expect(page).to have_content("erin")
    expect(page).to have_content("June 28 at 4:00 am")
  end
end