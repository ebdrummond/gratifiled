class DownloadsController < ApplicationController

  def show
    @fileshare = Fileshare.find(params[:fileshare_id])
    data = open(@fileshare.document.url)
    send_data(data.read, filename: @fileshare.fileshare_file_name,
                         type: @fileshare.fileshare_content_type,
                         disposition: 'attachment',
                         stream: 'true')
    @fileshare.download_sequence
  end
end