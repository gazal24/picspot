class UserController < ApplicationController
  def list
    @user = User.find(:all)
  end

  #THIS IS TO VIEW ANY USERS PROFILE. PUT ONLY SPECIFIC DETAILS HERE
  def show
    @user = User.find(params[:id])

    #this is for searching the existing friends of this use
    @friends1 = Friend.all(:conditions => {:user1 => @user.id, :accepted => 1}).collect{|f| f.user2}
    @friends2 = Friend.all(:conditions => {:user2 => @user.id, :accepted => 1}).collect{|f| f.user1}
    @friends = @friends1 + @friends2
    
    @albums = @user.albums
  end
  
  #THIS IS MY PROFILE HOMEPAGE. PUT ALL THE IMPORTANT DETAILS HERE
  def showme
    @user = User.find(session[:user].id)
    
    #this is for searching the existing friends of this use
    @friends1 = Friend.all(:conditions => {:user1 => @user.id, :accepted => 1}).collect{|f| f.user2}
    @friends2 = Friend.all(:conditions => {:user2 => @user.id, :accepted => 1}).collect{|f| f.user1}
    @friends = @friends1 + @friends2
    
    #this is for searching the people who has send follow request to this user
    @request = Friend.all(:conditions => {:user2 => @user.id, :accepted => 0}).collect{|r| r.user1}
    
    @albums = @user.albums    
  end
  
  def search
    @search = User.find_all_by_name(params[:query]["name"])
  end
  
  def follow
    @f = Friend.new(:user1 => session[:user].id, :user2 => params[:id], :accepted => 0)
    if @f.save
      redirect_to :action => 'show', :id => session[:user].id
    else
      redirect_to :action => 'search'
    end
  end

  def accept
    @friend = Friend.all(:conditions => {:user1 => params[:id], :user2 => session[:user].id, :accepted => 0})
    @friend = Friend.find(@friend.to_param.to_i)
    if !@friend.blank?
      @friend.accepted = 1
      if @friend.save
        redirect_to :action => 'show', :id => session[:user].id
      else
        redirect_to :action => 'search'
      end
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user] = User.authenticate(@user.email, @user.password)
      #      flash[:message] = "Signup successful"
      redirect_to :action => 'show', :id => session[:user].id
    else
      redirect_to :controller => 'homepage', :action => 'index'
    end
  end
  
  def login
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user.blank?
      redirect_to :action => 'index', :controller => 'homepage'
    else
      # flash[:message]  = "Login successful"
      session[:user] = @user
      redirect_to :action => 'showme', :controller => 'user'
    end
  end
  
  def edit
    @user = session[:user]
  end

  def update
    @user = session[:user]
    if @user.update_attributes(params[:user])
      redirect_to :action => 'showme', :controller => 'user'
    else
      render :action => 'edit'
    end
  end
  
  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  #======== L O G I N =======================

  
  def signup
    @user = User.new(@params[:user])
    if request.post?  
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        flash[:message] = "Signup successful"
        redirect_to :action => "welcome"          
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end
  

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end

  def welcome
  end
  def hidden
  end

end
