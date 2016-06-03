module Api::PicturesHelper
  def connect_to_storage 
    @drive_session ||= GoogleDrive.saved_session(config_path)
  end

  def root_folder
    @drive_session.collection_by_title(CiciStorage::Application::config.storage_folder)
  end

  def upload_file(user, name, contents, content_type)
    folder = user_folder(user)
    file = @drive_session.upload_from_io(
        StringIO.new(Base64.decode64(contents)), name, :content_type => content_type)
    folder.add(file)
    @drive_session.root_collection.remove(file)
  end

  def download_file(user, name, content_type, io)
    folder = root_folder.subcollection_by_title(user.to_s)
    file = folder.file_by_title(name)
    if !file.nil?
      file.download_to_io(io, :content_type => content_type)
    end
  end

  def request_user(json = nil)
    if json.nil?
      json = JSON.parse(request.body.read)
    end
    token = json["token"]
    user = User.find_by(api_token: token)
    user.nil?? nil : user
  end
 
  private
    def config_path
      File.join(Rails.root, "config", "google_drive.json").to_s
    end

    def user_folder(user)
      folder = root_folder.subcollection_by_title(user.to_s)
      if folder.nil?
        folder = root_folder.create_subcollection(user.to_s)
      end
      folder
    end
end
