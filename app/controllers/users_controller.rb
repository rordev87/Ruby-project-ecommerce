class UsersController < ApplicationController

  def new
    @user = User.new
  end
   def index
    @user = User.paginate page: params[:page]
  end
  
  def create
   @user = User.new user_params  
   if @user.save     
   @user.send_activation_email   
   flash[:info] = "Please check your email to activate your account."  
   redirect_to root_url   
   else      
   render :new  
   end 
  end

   def show
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "user_invalid"
    redirect_to root_url
  end
  def edit
   @user = User.find(params[:id])
  end

   def update
    @user = User.find_by(params[:id])
    if @user.update_attributes user_params
      flash[:success] = I18n.t "user.edit.ud_pf_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :user_name, :email,:address,
      :password, :password_confirmation
  end
  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
      flash[:danger] = t "user_invalid"
      redirect_to root_url
  end

end
