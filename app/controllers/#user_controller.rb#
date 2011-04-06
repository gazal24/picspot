class UserController < ApplicationController
  def list
    @user = User.find(:all)
  end
  def show
    @user = User.find(params[:id])
    @friends1 = Friend.all(:conditions => {:user1 => @user.id}).collect{|f| f.user2}
    @friends2 = Friend.all(:conditions => {:user2 => @user.id}).collect{|f| f.user1}    
    @friends = @friends1 + @friends2
    p @friends
  end

  def search
    @search = User.find_all_by_name(params[:query]["name"])
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
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
