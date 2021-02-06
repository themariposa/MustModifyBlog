class BirdsongsController < ApplicationController
  def show
    bird = params[:id]
    filename = "./public/#{bird}.mp3"

    if File.exist?(filename)
      send_file filename, disposition: 'attachment'
    end
  end
end
