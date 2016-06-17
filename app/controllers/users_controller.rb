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
    if User.invite!(email: @user.email, admin: @user.admin)
      flash!(:success, locals: { email: @user.email })
      redirect_to users_path
    else
      flash_now!(error: @user.errors.full_messages[0])
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      flash!(:success, locals: { email: @user.email })
      redirect_to users_path
    else
      flash_now!(error: @user.errors.full_messages[0])
      render('edit')
    end
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update_with_password(user_update_password_params)
      flash!(:success)
      sign_in @user, bypass: true
      redirect_to root_path
    else
      flash_now!(error: @user.errors.full_messages[0])
      render('edit_profile')
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash!(:success, locals: { email: @user.email })
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
