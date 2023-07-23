# frozen_string_literal: true

class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :review
  # has_one :notification, as: :subject, dependent: :destroy

  # post_idとuser_id　の組は1組しかできないようにしている
  validates_uniqueness_of :review_id, scope: :user_id

  def get_review_image(width, height)
    unless review_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      review_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    review_image.variant(resize_to_limit: [width, height]).processed
  end
end
