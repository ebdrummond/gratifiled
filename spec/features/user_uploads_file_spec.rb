require 'spec_helper'

describe "a user uploads a file" do
  before do
    visit root_path
  end

  it "has a button to add a new file" do
    expect(page).to have_button("Yes!")
  end
end