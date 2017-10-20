class PicturesController < ApplicationController

  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_ownership, only: [:edit, :update, :delete]

  def index
    @most_recent_pictures = Picture.most_recent_five
    @older_pictures = Picture.created_before(1.month.ago)
    @created_in_year = Picture.pictures_created_in_year(2017)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    # @picture.title = params[:picture][:title]
    # @picture.artist = params[:picture][:artist]
    # @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    # @picture.title = params[:picture][:title]
    # @picture.artist = params[:picture][:artist]
    # @picture.url = params[:picture][:url]

    if @picture.update(picture_params)
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to "/pictures"
  end

  private

  def load_picture
     @picture = Picture.find(params[:id])
  end

  def ensure_ownership
    unless current_user && current_user.id == @picture.user_id
      # raise params.inspect
      flash[:alert] = "Please log in"
      redirect_to picture_path(@picture)
    end
  end

  def picture_params
    params.require(:picture).permit(:title, :artist, :url)
  end
end
