class UtilsController < ApplicationController

  ACCESS = {
    edit_persons: [:erd]
  }
  before_action -> { authorize(ACCESS) } # TODO need admin priv

  def erd
    raise 'Unauthorized action' unless Rails.env == 'development'
    system "rake erd filename=tmp/erd" #unless File.exists? 'erd.pdf'
    erd_pdf = IO.read('tmp/erd.pdf')
    send_data erd_pdf, file_name: 'erd.pdf', type: 'application/pdf', disposition: 'attachment'
  end
end

