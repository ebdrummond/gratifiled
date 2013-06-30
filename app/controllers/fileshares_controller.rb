class FilesharesController < ApplicationController

  def new
    @fileshare = Fileshare.new
    3.times { @fileshare.documents.build }
  end

  def create
    @fileshare = Fileshare.create(params[:fileshare])

    if @fileshare.save
      SendEmailsWorker.perform_async(@fileshare.id)
      redirect_to fileshare_confirmation_path(@fileshare)
    else
      render :new, message: "fileshare failed to save."
    end
  end

  def show
    @fileshare = Fileshare.find_by_uuid(params[:uuid])
  end

private
  def fileshare_params
    params.require(:fileshare).permit(documents_attributes: [:document])
  end
end