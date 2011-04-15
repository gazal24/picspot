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
    @FriendRequestSend = Friend.find(:all, :conditions => ["(user1 = #{session[:user].id} and user2 = #{params[:id]} and accepted = 0)"]).first
    @FriendRequestReceived = Friend.find(:all, :conditions => ["(user1 = #{params[:id]} and user2 = #{session[:user].id}  and accepted = 0)"]).first        
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
  

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user] = User.authenticate(@user.email, @user.password)
      flash[:notice] = "Signup successful"
      redirect_to :action => 'showme'
    else
      flash[:error] = "Something is wrong"
      redirect_to :controller => 'homepage', :action => 'index'
    end
  end
  
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
#     @friend = Friend.all(:conditions => {:user1 => params[:id], :user2 => session[:user].id, :accepted => 0})
#     @friend = Friend.find(@friend.to_param.to_i)
#     if !@friend.blank?
#       @friend.accepted = 1
#       if @friend.save
#         redirect_to :action => 'show', :id => session[:user].id
#       else
#         redirect_to :action => 'search'
#       end
#     end
  end
  
  def unfollow
    @f = Friend.find(params[:id])
    user2 = @f.user2
    @f.destroy
    @f.save
    redirect_to :action => 'show', :controller => 'user', :id => user2 
    flash[:notice] = "Follow request cancel"
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
