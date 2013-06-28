class DownloadsController < ApplicationController

  def show
    @document = Document.find(params[:document_id])
    data = open(@document.document.url)
    send_data(data.read, filename: @document.document_file_name,
                         type: @document.document_content_type,
                         disposition: 'attachment',
                         stream: 'true')
    SendDownloadAlertsWorker.perform_async(@document.id)
  end
end