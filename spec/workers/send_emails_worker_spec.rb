require 'spec_helper'

describe SendEmailsWorker do
  xit "receives email info from the Document controller" do
    SendEmailsWorker.should_receive(:perform).with(1)
    DocumentsController.create(name: "erin",
                               email: "erin@sample.com",
                               recipient_email: "brock@sample.com")
  end
end