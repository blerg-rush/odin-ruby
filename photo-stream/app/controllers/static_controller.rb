class StaticController < ApplicationController
  def index; end

  def show
    FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']
    flickr = FlickRaw::Flickr.new
    @photos = flickr.people.getPhotos(user_id: params[:user_id])
  end
end
