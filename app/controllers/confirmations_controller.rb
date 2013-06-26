class ConfirmationsController < ApplicationController

  def show
    @document = Document.find(params[:document_id])
  end
end