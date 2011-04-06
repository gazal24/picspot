class AlbumController < ApplicationController
  def new
    @album = Album.new
  end
  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to :action => 'show', :controller => 'album' , :id => @album.id
    else
      render :action => 'show', :controller => 'user'
    end
  end
  def show
    @album = Album.find(params[:id])
    @pics = @album.pictures
    @user = @album.user
  end

end
