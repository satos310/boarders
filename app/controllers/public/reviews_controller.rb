class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    # raty.js用のフォーム
    @star = Star.new
  end

  def create
    @review = Review.new(review_params)
    @review.stars.build(name: "ゲレンデ", score: params[:star][:star])
    @review.stars.build(name: "コストパフォーマンス", score: params[:star][:star2])
    @review.stars.build(name: "接客・サービス", score: params[:star][:star3])
    @review.stars.build(name: "設備の充実", score: params[:star][:star4])
    @review.stars.build(name: "周辺設備", score: params[:star][:star5])

    if @review.save
      # @review.star.create(name: "ゲレンデ", score: params[:star][:star2])
      redirect_to homes_top_path
    else
      render :new
    end
  end

  def index
  end

  def show
    @review = Review.find(params[:id])
    # raty..jsの平均値
    @star_avg = Star.where(review_id: params[:id]).average(:star)
    # すでに評価済みかの確認フラグ
    @star_flg = Star.find(use_id: current_user_id, review_id: params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  def destroy
    Review.find(params[:id]).destroy()
    redirect_to root_path
  end

  private

  def review_params
    # mergeメソッドでユーザーIDをStrongParameterに追加
    params.require(:review).permit(:title, :body, :review_image)
          .merge(user_id: current_user.id)
  end

  # def star_params
  #   params.require(:star).permit(:name, :score)
  # end
end
