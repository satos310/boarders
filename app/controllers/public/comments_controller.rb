class Public::CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(comment_params)
    @comment.review_id = @review.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments  #render先にjsファイルを指定
    else
      render :error
    end
  end

  def destroy
    Comment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    #renderしたときに@reviewのデータがないので@reviewを定義
    @review = Review.find(params[:review_id])
    render :comments  #render先にjsファイルを指定
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
