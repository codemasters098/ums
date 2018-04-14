class AdminController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_admin

  layout "admin"
  
  def index
  	@users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_index_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def authenticate_admin
    if session[:admin_id].nil?
         flash[:danger] = "Please log in to Access Admin Panel."
         redirect_to :controller => 'home', :action => 'sign_in'
    else
      
    end
      
  end

  def log_out
    session[:admin_id] = nil
    session[:admin_name] = nil
    redirect_to :controller => 'home', :action => 'sign_in'
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :password, :password_confirmation, :activated)
    end

end
