class Public::PickupsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :review_params, only: [:create, :destroy]

  def create
    Pickup.create(user_id: current_user.id, review_id: @review.id)
  end
  
  def destroy
    pickup = Pickup.find_by(user_id: current_user.id, review_id: @review.id)
    pickup.destroy
  end
  
  private
  
  def review_params
    @review = Review.find(params[:review_id])
  end
end
