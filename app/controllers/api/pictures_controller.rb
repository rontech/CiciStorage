class Api::PicturesController < ApplicationController
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
    json = request_json
    if json.nil?
      render :json => {error: "No file uploaded."}
    else
      # decode the base64
      data = StringIO.new(Base64.decode64(json["data"]))

      # assign some attributes for carrierwave processing
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = json["original_filename"]
      data.content_type = json["content_type"]
      picture = Picture.new(name: json["original_filename"], type: json["content_type"])
      if picture.save
        render :json => {url: picture.id}
      else
      render :json => {error: "Failed to save."}
      end
    end
  end

  private
    def request_json
      json = JSON.parse(request.body.read)
      token = json["token"]
      user = User.find_by(api_token: token)
      user.nil?? nil : json
    end

    def request_user
      json = JSON.parse(request.body.read)
      token = json["token"]
      user = User.find_by(api_token: token)
      user.nil?? nil : user
    end
end
