class UserController < ApplicationController
  def list
    @user = User.find(:all)
  end

  #THIS IS TO VIEW ANY USERS PROFILE. PUT ONLY SPECIFIC DETAILS HERE
  def show
    redirect_to :action => 'showme' if params[:id].to_s == session[:user].id.to_s

    @user = User.find(params[:id])

    #this is for searching the existing friends of this use
    @friends1 = Friend.all(:conditions => {:user1 => @user.id, :accepted => 1}).collect{|f| f.user2}
    @friends2 = Friend.all(:conditions => {:user2 => @user.id, :accepted => 1}).collect{|f| f.user1}
    @friends = @friends1 + @friends2
    
    @albums = @user.albums
    
    # @isFriend = Friend.find(:all, :conditions => ["(user1 = #{session[:user].id} and user2 = #{params[:id]})"]).first
    @FriendRequest = Friend.find(:all, :conditions => ["(user1 = #{session[:user].id} and user2 = #{params[:id]}) OR (user1 = #{params[:id]} and user2 = #{session[:user].id})"]).first
  end
  
  #THIS IS MY PROFILE HOMEPAGE. PUT ALL THE IMPORTANT DETAILS HERE
  def showme
    @user = User.find(session[:user].id)
    
    #this is for searching the existing friends of this use
    @friends1 = Friend.all(:conditions => {:user1 => @user.id, :accepted => 1}).collect{|f| f.user2}
    @friends2 = Friend.all(:conditions => {:user2 => @user.id, :accepted => 1}).collect{|f| f.user1}
    @friends = @friends1 + @friends2
    
    #this is for searching the people who has send follow request to this user
    @FriendRequest = Friend.find(:all, :conditions => ["(user2 = #{session[:user].id} and accepted = 0)"])
    @albums = @user.albums    
  end
  
  def search
    @search = User.find_all_by_name(params[:query]["name"])
  end
  

  def create
    @user = User.new(params[:user])
    if @user.save and params[:user]["password"] == params[:check]["repassword"]
      session[:user] = User.authenticate(@user.email, @user.password)
      flash[:notice] = "Signup successful"
      redirect_to :action => 'showme'
    else
      flash[:error] = "Wrong entry"
      redirect_to :controller => 'homepage', :action => 'index'
    end
  end
  
  def edit
    @user = session[:user]
  end

  def update
    @user = session[:user]
    if @user.update_attributes(params[:user]) and params[:user]["password"] == params[:check]["repassword"]
      redirect_to :action => 'showme', :controller => 'user'
    else
      flash[:error] = "Wrong entry"      
      render :action => 'edit'
    end
  end
  
  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def follow
    @f = Friend.new(:user1 => session[:user].id, :user2 => params[:id], :accepted => 0)
    if @f.save
      flash[:notice] = "Follow request send to #{User.find(params[:id]).name}"
      redirect_to :action => 'showme'
    else
      redirect_to :action => 'search'
    end
  end

  def accept
    @f = Friend.find(params[:id])
    @f.accepted = 1
    @f.save
    flash[:success] = "Accepted"
    redirect_to :action => 'showme', :controller => 'user'
  end
  
  def unfollow
    Friend.find(params[:id]).destroy
    flash[:error] = "Follow cancel"
    redirect_to :action => 'showme', :controller => 'user'
  end
  

  #======== L O G I N =======================

  def login
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user.blank?
      flash[:error] = "Wrong Email-Password"
      redirect_to :action => 'index', :controller => 'homepage'
    else
      flash[:success]  = "Login successful"
      session[:user] = @user
      redirect_to :action => 'showme', :controller => 'user'
    end
  end
  
  def logout
    session[:user] = nil
    flash[:notice] = 'Logged out'
    redirect_to :action => 'index', :controller => 'homepage'
  end

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
