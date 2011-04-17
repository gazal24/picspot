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
  def edit 
    @album = Album.find(params[:id])
    @user = @album.user
  end
  def update
    @album = Album.find(params[:album]["id"])
    if @album.update_attributes(params[:album])
      redirect_to :action => 'show', :controller => 'album', :id => @album.id
    else
      render :action => 'edit'
    end
  end
  def delete 
    Album.find(params[:id]).destroy
    redirect_to :action => 'show', :controller => 'user', :id => params[:uid]
  end
end
