class Public::UsersController < ApplicationController
  def friends
    @friends = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    # mergeメソッドでユーザーIDをStrongParameterに追加
    params.require(:user).permit(:name, :introduction, :user_image)
  end
end
