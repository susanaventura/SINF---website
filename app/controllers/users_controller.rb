class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = find_user_with_pri_info(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if !(exists_in_primavera = get_client(@user.username.upcase)) && @user.valid?
      if post_client(@user)
        @user.save
        flash[:info] = "Welcome #{@user.name}!"
        redirect_to root_url
      else
        @user.errors[:base] << 'Error creating user! Please try again later'
        render 'new'
      end
    else
      if exists_in_primavera
        @user.errors[:username] << 'already exists!'
      end
      render 'new'
    end
  end

  def edit_address
    @user = find_user_with_pri_info(params[:id])
  end

  def edit_account
    @user = find_user_with_pri_info(params[:id])
  end

  def update
    if (@user = find_user_with_pri_info(params[:id]))
      @user.assign_attributes(user_params(params[:user][:page_source]))
      if @user.valid?
        if put_client(@user)
          @user.save
          flash[:success] = 'Profile updated'
          redirect_to @user
        else
          # Error sending put client to primavera
          @user.errors[:base] << 'Error updating user! Please try again later'
          render params[:user][:page_source]
        end
      else
        # Error updating local data about client
        render params[:user][:page_source]
      end
    else
      # Error getting primavera client
      @user.errors[:base] << 'Error updating user! Please try again later'
      render params[:user][:page_source]
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  def user_params(index = :all)
    params.require(:user).permit(User.attributes(index))
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def find_user_with_pri_info(id)
    if (user = User.find(id)) && (pri_client = get_client(user.username))
      user.set_info_from_primavera(pri_client)
      user
    else
      nil
    end
  end
end
