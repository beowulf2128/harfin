class UtilsController < ApplicationController

  def erd
    raise 'Unauthorized action' unless Rails.env == 'development'
    system 'rake erd' #unless File.exists? 'erd.pdf'
    erd_pdf = IO.read('erd.pdf')
    send_data erd_pdf, file_name: 'erd.pdf', type: 'application/pdf', disposition: 'attachment'
  end
end

