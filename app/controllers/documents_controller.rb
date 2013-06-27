class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(params[:document])

    if @document.save
      SendEmailsWorker.perform_async(@document.id)
      redirect_to document_confirmation_path(@document)
    else
      render :new, message: "Document failed to save."
    end
  end

  def show
    @document = Document.find_by_uuid(params[:uuid])
  end
end