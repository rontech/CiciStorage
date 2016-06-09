require "google_drive"

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
session = GoogleDrive.saved_session("config.json")

# Gets list of remote files.
session.files.each do |file|
  p file.title
end
