class PicturesController < ApplicationController

  before_action :ensure_login, except: [:index, :show]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]

  def index
    @most_recent_pictures = Picture.most_recent_five
    @older_pictures = Picture.created_before(1.month.ago)
    @created_in_year = Picture.pictures_created_in_year(2017)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = params[:picture][:user_id]

    if @picture.save
      redirect_to "/pictures"
    else
      render :new
    end
  end

  def show
    return ensure_ownership
  end

  def edit
    return ensure_ownership
  end

  def update
    return ensure_ownership

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]


    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to "/pictures"
  end

  private

  def load_picture
     @picture = Picture.find(params[:id])
  end

  def ensure_ownership
    unless current_user == @picture.user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

  def ensure_login
    unless current_user
      flash[:alert] = "Must be logged in"
    end
  end
end
