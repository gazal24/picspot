class PicturesController < ApplicationController
  layout 'standard'
  def index
    @pictures = Picture.find(:all)
  end
  
  
  def show
    @picture = Picture.find(params[:id])
    @album = @picture.album
    @user = @picture.user
    @comments = @picture.comments
  end
  
  def new
    @picture = Picture.new
  end
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def create
    @picture = Picture.new(params[:picture])
    @album = Album.find(params[:picture][:album_id])
    if @picture.save
      flash[:success] = 'Picture was successfully uploded.'
      redirect_to :action => 'show', :controller => 'pictures' , :id => @picture.id
    else
      redirect_to :action => 'show', :controller => 'album' , :id => @album.id
    end
  end
  
  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      flash[:success] = 'Picture was successfully updated.'
    else
      flash[:error] = 'Picture was not successfully updated.'      
    end
  end
  
  def delete
    album_id = Picture.find(params[:id]).album.id
    Picture.find(params[:id]).destroy
    flash[:error] = "Image deleted"
    redirect_to :action => 'show', :controller => 'album', :id => album_id
  end
end
