class Public::StarsController < ApplicationController
  before_action :authenticate_user!

  def create
    @star = Star.new(star_params)
    if @rstar.save!
      # ↓ の記述がStar.newと合っていない？
      redirect_to new_review_path(params[:review_id])
    else
      render :edit
    end
  end
  
  def destroy
    star = Star.find_by(user_id: current_user.id, review_id: params[:review_id])
    # 自分自身の評価のみ削除を許可
    redirect_to reviews_path and return unless star.user_id == current_user.id
    star.destroy() # 評価削除
    redirect_to review_path(params[:review_id])
  end

  private

  def star_params
    # mergeメソッドでユーザーID, 投稿_IDをStrongParameterに追加
    params.require(:star).permit(:star)
          .merge(
            user_id: current_user.id,
            review_id: params[:review_id]
          )
  end
end
