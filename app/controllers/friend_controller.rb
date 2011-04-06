class FriendController < ApplicationController
  def list
    @user = User.find(:all)
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    p "hehyya"
    p @user
    if @user.save
      redirect_to :action => 'show', :id => @user.id
    else
      @subjects = Subject.find(:all)
      render :action => 'new'
    end
  end
  def edit
    @book = Book.find(params[:id])
    @subjects = Subject.find(:all)
  end
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to :action => 'show', :id => @book
    else
      @subjects = Subject.find(:all)
      render :action => 'edit'
    end
  end
  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
