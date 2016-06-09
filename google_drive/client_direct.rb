require 'google/apis/drive_v2'
require "google_drive"

session = GoogleDrive.saved_session("config.json")

#Drive = Google::Apis::DriveV2 # Alias the module
#drive = Drive::DriveService.new
#drive.authorization = ... # See Googleauth or Signet libraries
drive = session.drive

# Upload a file
metadata = {
  name: 'test.jpg',
  title: 'test.jpg',
  convert: false
}
p Time.now
file = drive.create_file(metadata,
                                 fields: 'id',
                                 upload_source: 'test.jpg',
                                 content_type: 'image/jpeg')
p Time.now

# Download a file
drive.get_file(file.id, download_dest: 'out.jpg') 
p Time.now
