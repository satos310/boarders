class Public::HomesController < ApplicationController
  def top
    @users = User.all
    @reviews = Review.all
  end
  
  def about
  end
end
