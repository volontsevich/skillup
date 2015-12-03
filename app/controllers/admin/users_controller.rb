class Admin::UsersController < ApplicationController;
  before_action :authenticate_user!
  before_action :find_user, only: [:edit, :update]

  def index
    @users=User.all
  end

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

  def edit

  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to admin_users_path
    else

      render :action => 'edit'
    end
  end

  def show
    redirect_to :controller => '/surveys', :action => 'index', :user_id => params[:id]
  end

  private

  def user_params

    params.require(:user).permit(:email, :name, :password, :password_confirmation, :admin)
  end

  def find_user
    @user=User.find(params[:id])
    #debugger

  end


end