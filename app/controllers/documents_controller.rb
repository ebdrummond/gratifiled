class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(params[:document])

    if @document.save
      redirect_to document_confirmation_path(@document)
    else
      render :new, message: "Document failed to save."
    end
  end
end