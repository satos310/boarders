class Public::UsersController < ApplicationController
  def friends
    @friends = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def review_params
    # mergeメソッドでユーザーIDをStrongParameterに追加
    params.require(:review).permit(:name, :introduction, :user_image)
          .merge(user_id: user.id)
  end
end
