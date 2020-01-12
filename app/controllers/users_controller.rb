class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
  before_action :check_admin, except: [:edit_profile, :update_profile]

  def index
    @users = User.search(params[:search]).order(sort_column + ' ' + sort_direction)
                 .paginate(page: params[:page], per_page: 25)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    flash_now!(error: "Inviting users is disabled on the demo version")
    render('new')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    flash_now!(error: "Updating users is disabled on the demo version")

    render('edit')
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    flash_now!(error: "Updating users is disabled on the demo version")
    render('edit_profile')
  end

  def destroy
    flash!(error: "Deleting users is disabled on the demo version")
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :admin)
  end

  def user_update_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params.require(:user).permit(:email, :admin)
    else
      user_params
    end
  end

  def user_update_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
