class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
