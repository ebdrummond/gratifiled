require 'spec_helper'

describe Document do
  let(:document) {Document.new(name: "erin",
                               email: "erin@example.com",
                               recipient_email: "brock@example.com",
                               message: "the dog ate my homework")}

  it "requires a name" do
    expect{ document.name = "" }.to change { document.valid? }.to be_false
  end

  it "requires an email" do
    expect{ document.email = "" }.to change { document.valid? }.to be_false
  end

  it "requires a recipient email" do
    expect{ document.recipient_email = "" }.to change { document.valid? }.to be_false
  end

  it "does not require a message" do
    document.message = ""
    expect(document).to be_valid
  end
end
