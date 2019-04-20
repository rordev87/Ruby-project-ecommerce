class Admin::UsersController < ApplicationController
  before_action :load_user, only: :destroy

  def index
    @users = User.list_users_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_delete"
    else
      flash[:danger] = t "user_invalid"
    end
    redirect_to admin_users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "user_invalid"
    redirect_to root_url
  end

end
