class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end
  def create
    # @video = Video.new(video_params)
    # @video = Yt::Video.new url: (params[:link])
    resource = (video_params)
    video = Yt::Video.new url: resource["link"]
    resource["uid"] = video.id
    resource["title"] = video.title
    resource["likes"] = video.like_count
    resource["dislikes"] = video.dislike_count
    resource["published_at"] = video.published_at
    @video = Video.new(resource) 


    if @video.save
      flash[:success] = 'Video added!'
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:link)
  end
end
