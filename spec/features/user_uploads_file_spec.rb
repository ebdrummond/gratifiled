require 'spec_helper'

describe "a user sends an email to recipient" do
  def create_valid_document
    visit new_document_path
    fill_in("document[name]", :with => "erin")
    fill_in("document[email]", :with => "erin@example.com")
    fill_in("document[recipient_email]", :with => "brock@example.com")
    fill_in("document[message]", :with => "the dog ate my homework")
  end

  it "has a button to add a new file" do
    visit root_path
    expect(page).to have_button("Yes!")
  end

  it "takes you to the new file path upon clicking 'Yes!' button" do
    visit root_path
    click_button("Yes!")
    expect(current_path).to eq(new_document_path)
  end

  it "has a form to upload a new file" do
    visit new_document_path
    expect(page).to have_field("document[name]")
    expect(page).to have_field("document[email]")
    expect(page).to have_field("document[recipient_email]")
    expect(page).to have_field("document[message]")
    expect(page).to have_button("Send document")
  end

  context "with valid input to create the document" do
    it "creates a new document instance" do
      create_valid_document
      expect{ click_button("Send document") }.to change(Document, :count).by(1)
    end

    it "redirects to a confirmation page on document creation" do
      create_valid_document
      click_button("Send document")
      expect(current_path).to eq(document_confirmation_path(Document.last.id))
    end

    it "includes confirmation details of the created document" do
      create_valid_document
      click_button("Send document")
      document = Document.last
      expiration = (document.created_at + 3.days).to_time.localtime
      formatted_expiration = expiration.strftime("%B %-d at %-l:%M %P")
      expect(page).to have_content("erin")
      expect(page).to have_content("erin@example.com")
      expect(page).to have_content("brock@example.com")
      expect(page).to have_content("the dog ate my homework")
      expect(page).to have_content(formatted_expiration)
    end
  end

  context "with invalid input to create the document" do
    it "does not create the new document" do
      visit new_document_path
      fill_in("document[name]", :with => "")
      fill_in("document[email]", :with => "erin@example.com")
      fill_in("document[recipient_email]", :with => "brock@example.com")
      fill_in("document[message]", :with => "the dog ate my homework")
      click_button("Send document")
      expect(current_path).to eq(documents_path)
      expect(page).to have_content("Name can't be blank")
    end
  end
end