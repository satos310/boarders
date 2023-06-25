class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!

  # フォローフォロワー一覧処理
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
