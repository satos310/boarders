class Public::UsersController < ApplicationController
  before_action :set_user, only: [:pickups]

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
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  # pluck → 指定したカラムのレコードの配列を取得
  def pickups
    pickups = Pickup.where(user_id: @user.id).pluck(:review_id)
    @pickup_reviews = Review.find(pickups)
    @comment = Comment.new
  end

  private

  def user_params
    # mergeメソッドでユーザーIDをStrongParameterに追加
    params.require(:user).permit(:name, :introduction, :user_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
