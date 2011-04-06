class TodoController < ApplicationController
  def index
    @posts = Todo.find(:all)
  end
  def new
    @post = Todo.new
  end
  def create
    @post = Todo.new(params[:post])
    @post.save
    redirect_to :action => 'index'
  end

  def delete 
    Todo.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
