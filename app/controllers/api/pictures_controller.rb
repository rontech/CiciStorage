class Api::PicturesController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :connect, only: [:create, :show, :destroy]

  def login
    request_json = JSON.parse(request.body.read)
    if request_json.blank?
      render :json => {error:  "Invalid request body."}
    else
      email = request_json["email"]
      password = request_json["password"]
      user = User.find_by(email: email.downcase)
      if user && user.authenticate(password)
        if user.activated?
          user.update_api_token(User.new_token)
          render :json => {token:  user.api_token}
        else
          render :json => {error:  "Account not activated."}
        end
      else
          render :json => {error:  "Invalid email/password combination."}
      end
    end
  end

  def logout
    user = request_user
    if user.nil?
      render :json => {id: nil}
    else
      user.update_api_token(nil)
      render :json => {id:  user.id}
    end
  end

  def create
    json = JSON.parse(request.body.read)
    user = request_user(json)
    if user.nil?
      render :json => {error: "No file uploaded."}
    else
      content_type = json["type"]
      picture = user.pictures.create(file_name: json["name"], 
                                      content_type: content_type)
      if picture.save
        file_id = upload_file(user, picture.url_key, StringIO.new(Base64.decode64(json["data"])), content_type)
        picture.gd_id = file_id
        picture.save
        access_path = request.base_url + (api_picture_path id: picture.url_key)
        render :json => {url: "#{access_path}"}
      else
        render :json => {error: "Failed to save."}
      end
    end
  end

  def show
    key = params[:id]
    picture = Picture.find_by(url_key: key)
    if picture.nil?
      render :json => {error: "File not found."}
    else
      sio = StringIO.new
      download_file(picture.gd_id, sio)
      sio.rewind
      send_data sio.read, :filename => picture.file_name, :type => picture.content_type
    end
  end

  def destroy
    json = JSON.parse(request.body.read)
    user = request_user(json)
    if user.nil?
      render :json => {error: "No file deleted."}
    else
      key = params[:id]
      picture = Picture.find_by(url_key: key)
      remove_file(user, picture.gd_id)
      render :json => {id: "#{key}"}
    end
  end
end
