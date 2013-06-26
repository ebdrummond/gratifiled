require 'spec_helper'

describe "a user sends an email to recipient" do
  before do
    visit root_path
  end

  it "has a button to add a new file" do
    expect(page).to have_button("Yes!")
  end

  it "takes you to the new file path upon clicking 'Yes!' button" do
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
end