class Public::HomesController < ApplicationController
  def top
    @users = User.all
    @reviews = Review.all
    @stars = Star.all
    @all_rating = '総合評価'
  end

  def about
  end

  private

  def review_params
    params.require(:review).permit(:comment, :name, :score, :all_acore).merge(
      user_id: current_user.id, review_id: params[:review_id]
    )
  end
end
