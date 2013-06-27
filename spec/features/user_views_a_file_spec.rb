require 'spec_helper'

describe "user views a file" do
  let!(:document) {Document.create(name: "erin",
                                   email: "erin@sample.com",
                                   recipient_email: "brock@sample.com",
                                   message: "Here's a picture of Lola May at Galvanize!",
                                   document: File.new('spec/fixtures/lola_may.png'))}

  it "displays the document information" do
    document.created_at = DateTime.new(2013, 6, 25, 10)
    document.save
    visit document_path(document.uuid)
    expect(page).to have_content("Here's a picture of Lola May at Galvanize!")
    expect(page).to have_content("June 28 at 4:00 am")
    expect(page).to have_content("lola_may.png")
    expect(page).to have_content("570.405 KB")
    expect(page).to have_link("Download file")
  end
end