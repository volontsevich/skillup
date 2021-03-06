class Admin::UsersController < ApplicationController;
  before_action :authenticate_user!
  before_action :find_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def index
    @users=User.all.page(params[:page]).per(5)
  end

  def show
    redirect_to :controller => '/surveys', :action => 'index', :user_id => params[:id]
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to admin_users_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :admin)
  end

  def find_user
    @user=User.find(params[:id])
  end

end