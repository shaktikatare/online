class UsersController < ApplicationController
  before_filter :authenticate_user, :only => [:home,:edit_profile]
  def initialize_user
    @user = User.new
  end
  def login
    initialize_user
  end
  def signup
    initialize_user
  end
  def home
  end
  def create
    params[:user][:encrypted_password] =Digest::SHA1.hexdigest(params[:user][:encrypted_password])
    @user=User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user)
      redirect_to root_path
    else
      flash[:error]=@user.errors.full_messages.join("/br")
      render :signup  
    end
  end
  def check_login
    @user=User.where(:email => params[:user][:email],:encrypted_password => Digest::SHA1.hexdigest(params[:user][:encrypted_password])).first
    if @user.present?
      session[:user_id]=@user.id
      redirect_to home_users_path
    else
      initialize_user
      flash[:notice] = "Logged in failed"
      render :login
    end 
  end
  def authenticate_user
    if session[:user_id].present?
      @current_user=User.find(session[:user_id])
    else
      flash[:error] = "Please login first to access the page"
      redirect_to root_path and return
    end
  end
  def logout
    session[:user_id]=nil
    redirect_to root_path
  end
  def edit_profile
    initialize_user
  end
  def update_profile
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
    redirect_to home_users_path
    end
  end
end
