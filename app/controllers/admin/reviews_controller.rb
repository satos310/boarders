# frozen_string_literal: true

class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def hashtag
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.reviews.count }
    else
      name = params[:name]
      name = name.downcase
      @hashtag = Hashtag.find_by(hashname: name)
      @review = @hashtag.reviews
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.reviews.count }
    end
  end

  def search_tag
    # 検索結果画面でもタグ一覧表示
    @hashtags = Hashtag.all
    # 検索されたタグを受け取る
    @hashtag = Hashtag.find(params[:hashtag_id])
    # 検索されたタグに紐づく投稿を表示
    @reviews = @hashtag.reviews.page(params[:page]).per(10)
  end

  def index
    @reviews = Review.search(params[:keyword])
    @keyword = params[:keyword]
  end

  def show
    @review = Review.find(params[:id])
    @hashtags = @review.hashtags.all
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  private
    def review_params
      # mergeメソッドでユーザーIDをStrongParameterに追加
      params.require(:review).permit(:title, :body, :review_image, :star)
            .merge(user_id: current_user.id)
    end
end
