class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
end
