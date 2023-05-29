class Public::ReviewsController < ApplicationController

  def hashtag
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.reviews.count}
    else
      name = params[:name]
      name = name.downcase
      @hashtag = Hashtag.find_by(hashname: name)
      @review = @hashtag.reviews
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.reviews.count}
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

  def new
    @review = Review.new
    @hashtag = Hashtag.new
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
    @review.user_id = current_user.id
    hashtag_list = []
    receive_hashtag_list=params[:review][:name].split(/[[:blank:]]+|,[[:blank:]]+/).compact_blank
    receive_hashtag_list.each do |tag_name|
      hashtag_list << tag_name.delete_prefix("#").delete_prefix("＃")
    end
    if @review.save
      @review.save_hashtag(hashtag_list)
      redirect_to homes_top_path
    else
      render :new
    end
  end

  def index
    @reviews = Review.search(params[:keyword])
  end

  def show
    @review = Review.find(params[:id])
    @hashtags = @review.hashtags.all
  end

  def edit
    @review = Review.find(params[:id])
    @hashtags = @review.hashtags.all
    @tag_list = @review.hashtags.pluck(:name).join(',')
  end

  def update
    @review = Review.find(params[:id])
    @review.stars.find_by(name: "ゲレンデ").update(score: params[:star][:star])
    @review.stars.find_by(name: "コストパフォーマンス").update(score: params[:star][:star2])
    @review.stars.find_by(name: "接客・サービス").update(score: params[:star][:star3])
    @review.stars.find_by(name: "設備の充実").update(score: params[:star][:star4])
    @review.stars.find_by(name: "周辺設備").update(score: params[:star][:star5])

    # 入力されたタグを受け取る
    tag_list = params[:review][:name].split(/[[:blank:]]+|,[[:blank:]]+/).compact_blank
    if @review.update(review_params)
      # このreview_idに紐づいていたタグを@oldに入れる
      @old_relations = PostTag.where(review_id: @review.id)
      # それらを取り出し、消す。消し終わる
      @old_relations.each do |relation|
        relation.delete
      end
       @review.save_hashtag(tag_list)
      redirect_to review_path(@review.id), notice: '更新完了しました:)'
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
    params.require(:review).permit(:title, :body, :review_image, :star)
          .merge(user_id: current_user.id)
  end

  # def star_params
  #   params.require(:star).permit(:name, :score)
  # end
end
