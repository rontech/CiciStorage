class PicturesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :connect, only: [:create, :destroy]

  def create
    user = current_user
    @picture = user.pictures.build(picture_params)
    @picture.set_attributes
    if @picture.save
      File.open(@picture.temp_file.file.file) do |io|
        file_id = upload_file(user, @picture.url_key, io, @picture.content_type)
        @picture.gd_id = file_id
        @picture.save
      end
      File.unlink @picture.temp_file.file.file
      flash[:success] = "Picture created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    remove_file current_user,  @picture.gd_id
    @picture.destroy
    flash[:success] = "Picture deleted"
    redirect_to request.referrer || root_url
  end

  private

    def picture_params
      params.require(:picture).permit(:temp_file)
    end

    def correct_user
      @picture = current_user.pictures.find_by(id: params[:id])
      redirect_to root_url if @picture.nil?
    end
end
