class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    # 評価機能はまだ未実装
  end

  def create
    @review = Review.new
    if @review.save
      redirect_to homes_top_path
    else
      render :new
    end
  end

  def index
  end

  def show
    @review = Review.find(params[:id])
    # raty.js用のフォーム
    @star = Star.new
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
    params.require(:review).permit(:title, :bodty, :image)
          .merge(user_id: current_user.id)
  end
end
