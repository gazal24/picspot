class AlbumController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      flash[:notice] = "Album Created Successfully"
      redirect_to :action => 'show', :controller => 'album' , :id => @album.id
    else
      flash[:error] = "Wrong Entry"
      redirect_to :action => 'showme', :controller => 'user'
    end
  end
  def show
    @album = Album.find(params[:id])
    @picture = @album.pictures
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
    @album = Album.find(params[:id])
    @pictures = @album.pictures
    
    @pictures.each do |@p|
      @comments = @p.comments
      @comments.each do |@c|
        @c.destroy
        @c.save
      end
    end      
    
    pic_count = @pictures.count
    (0...pic_count).each do |i|
      @album.pictures[i].destroy
    end
    
    @album.destroy
    @album.save
    flash[:error] = "Album deleted"
    redirect_to :action => 'showme', :controller => 'user'
  end
end
