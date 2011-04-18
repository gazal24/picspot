class CommentController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @comment = Comment.new(params[:comment])
    @picture = Picture.find(params[:comment][:picture_id])
    if @comment.save
      redirect_to :action => 'show', :controller => 'pictures' , :id => @picture.id
    else
      render :action => 'show', :controller => 'album', :id => @picture.id
    end
  end

  def delete
    picture_id = Comment.find(params[:id]).picture.id
    Comment.find(params[:id]).destroy
    flash[:error] = "Comment deleted"
    redirect_to :action => 'show', :controller => 'pictures', :id => picture_id
  end

  
end
