require "google_drive"

class StaticPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end

  def contact
  end

  def connect_storage
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    config = Rails.root.join('config/google_drive.json').to_s
    se = GoogleDrive.saved_session(config)

    # Gets list of remote files.
    se.files.each do |file|
      p file.title
    end

    # Uploads a local file.
    #session.upload_from_file("hello.txt", "hello.txt", convert: false)

    # Downloads to a local file.
    #file = session.file_by_title("hello.txt")
    #file.download_to_file("/path/to/hello.txt")

    # Updates content of the remote file.
    #file.update_from_file("/path/to/hello.txt")
  end

  def callback
    p "--------------------------------------------"
    p request.body
  end
end
