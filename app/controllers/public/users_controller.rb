class Public::UsersController < ApplicationController
  before_action :set_user, only: [:pickups]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    #   params[:user].delete(:password)
    #   params[:user].delete(:password_confirmation)
    # end

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

  # 他のユーザーからのアクセスを制限
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to homes_top_path
    end
  end
end
