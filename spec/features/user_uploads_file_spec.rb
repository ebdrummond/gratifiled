require 'spec_helper'

describe "a user sends a file to recipient" do
  def create_valid_fileshare
    visit new_fileshare_path
    fill_in("fileshare[sender_name]", :with => "erin")
    fill_in("fileshare[sender_email]", :with => "erin@example.com")
    fill_in("fileshare[recipient_email]", :with => "brock@example.com")
    fill_in("fileshare[message]", :with => "the dog ate my homework")
    attach_file("fileshare[documents_attributes][0][document]", "spec/fixtures/lola_may.png")
  end

  it "has a button to add a new file" do
    visit root_path
    expect(page).to have_button("Yes!")
  end

  it "takes you to the new file path upon clicking 'Yes!' button" do
    visit root_path
    click_button("Yes!")
    expect(current_path).to eq(new_fileshare_path)
  end

  it "has a form to upload a new file" do
    visit new_fileshare_path
    expect(page).to have_field("fileshare[sender_name]")
    expect(page).to have_field("fileshare[sender_email]")
    expect(page).to have_field("fileshare[recipient_email]")
    expect(page).to have_field("fileshare[message]")
    expect(page).to have_button("Send file")
  end

  context "with valid input to create the file" do
    it "creates a new document instance" do
      create_valid_fileshare
      expect{ click_button("Send file") }.to change(Document, :count).by(1)
    end

    it "redirects to a confirmation page on file creation" do
      create_valid_fileshare
      click_button("Send file")
      expect(current_path).to eq(fileshare_confirmation_path(Fileshare.last.id))
    end

    it "includes confirmation details of the created file" do
      create_valid_fileshare
      click_button("Send file")
      fileshare = Fileshare.last
      expiration = (fileshare.created_at + 3.days).to_time.localtime
      formatted_expiration = expiration.strftime("%B %-d at %-l:%M %P")
      expect(page).to have_content("erin")
      expect(page).to have_content("erin@example.com")
      expect(page).to have_content("brock@example.com")
      expect(page).to have_content("the dog ate my homework")
      expect(page).to have_content(formatted_expiration)
    end
  end

  context "with invalid input to create the file" do
    it "does not create the new file" do
      visit new_fileshare_path
      fill_in("fileshare[sender_name]", :with => "")
      fill_in("fileshare[sender_email]", :with => "erin@example.com")
      fill_in("fileshare[recipient_email]", :with => "brock@example.com")
      fill_in("fileshare[message]", :with => "the dog ate my homework")
      click_button("Send file")
      expect(current_path).to eq(fileshares_path)
      expect(page).to have_content("Sender name can't be blank")
      expect(page).to have_content("Documents can't be blank")
    end
  end
end