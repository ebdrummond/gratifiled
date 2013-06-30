class ConfirmationsController < ApplicationController

  def show
    @fileshare = Fileshare.find(params[:fileshare_id])
  end
end