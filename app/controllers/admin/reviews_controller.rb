class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.search(params[:keyword])
    @keyword = params[:keyword]
  end

  def show
  end

  def edit
  end

  def update
  end
end
