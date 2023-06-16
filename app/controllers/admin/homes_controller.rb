class Admin::HomesController < ApplicationController
  def search
    if params[:keyword].present?
      @reviews = Review.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @reviews = Review.all
    end
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @hashtags = Hashtag.all
　  #検索されたタグを受け取る
    @hashtag = Hashtag.find(params[:hashtag_id])
　  #検索されたタグに紐づく投稿を表示
    @reviews = @hashtag.reviews.page(params[:page]).per(10)
  end

  def top
    @users = User.all
    @reviews = Review.page(params[:page]).per(10).order(created_at: :desc)
    @stars = Star.all
    @all_rating = '総合評価'
    @hashtag_list = Hashtag.all
    # pickups = Pickup.where(user_id: @user.id).pluck(:review_id)
    # @pickup_reviews = Review.find(pickups)
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
