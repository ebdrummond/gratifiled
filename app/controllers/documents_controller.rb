class DocumentsController < ApplicationController

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(params[:document])
  end
end