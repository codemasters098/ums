class HomeController < ApplicationController
  
  before_action :authenticate_user, only: [:index]
  #before_create :create_activation_digest

  def sign_in
    @user = User.new
  end

  def sign_up
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      
      if @user.save
        UserMailer.account_activation(@user).deliver
        format.html { redirect_to :controller => 'home', :action => 'index' }

      else
        format.html { render :sign_up }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  end

  #post sign_in method
  def sign_in_post

    @user = User.where(:email => params[:email]).first
    
    if @user.present? && @user.authenticate(log_params[:password]) && @user.activated? && @user.admin?
      session[:admin_id] = @user.id
      session[:admin_name] = @user.first_name + " " + @user.last_name
      flash[:notice] = "Signed in Successfully. Welcome to Admin Panel.."
      redirect_to :controller => 'admin', :action => 'index'
      
    elsif @user.present? && @user.authenticate(log_params[:password]) && @user.activated?
      session[:user_id] = @user.id
      session[:user_name] = @user.first_name + " " + @user.last_name

      flash[:notice] = "Signed in Successfully"
      redirect_to :controller => 'home', :action => 'index'
      
    else

      flash[:notice] = "Invalid Email or Password or May be your account is Not Activated. Contact Admin for Support"
      render :sign_in

    end
    
    

  end

  def authenticate_user
    if session[:user_id].nil?
         flash[:danger] = "Please log in to Continue."
         redirect_to :controller => 'home', :action => 'sign_in'
    else
      
    end
      
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil

    render :sign_in

  end

  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :activated)
    end

    def log_params
      params.permit(:email,:password)
    end

    # def create_activation_digest
    #   # Create the token and digest.
    #   self.activation_token  = User.new_token
    #   self.activation_digest = User.digest(activation_token)
    # end

    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

end
