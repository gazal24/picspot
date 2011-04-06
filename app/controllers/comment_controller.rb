class CommentController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @comment = Comment.new(params[:comment])
    p "#######################"
    p @comment
    @pic = Picture.find(params[:comment][:picture_id])
    if @comment.save
      redirect_to :action => 'show', :controller => 'picture' , :id => @pic.id
    else
      render :action => 'show', :controller => 'album', :id => @pic.id
    end
  end
  
end
