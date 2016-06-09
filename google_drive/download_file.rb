require "google_drive"

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
session = GoogleDrive.saved_session("config.json")

#upload file
p Time.now
session.upload_from_file("test.jpg", "test.jpg", convert: false, content_type:"image/jpg")
p Time.now

#download file
p Time.now
file = session.file_by_title("test.jpg")
#file.download_to_file("out.jpg")
sio = StringIO.new
file.download_to_io(sio)
sio.rewind
File.open("out.jpg", "w") do |f|
  f.puts(sio.read)
end
p Time.now
session.root_collection.remove(file)


