class Review < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :stars, dependent: :destroy

  has_one_attached :review_image

  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end

  def get_review_image(width, height)
    unless review_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      review_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    review_image.variant(resize_to_limit: [width, height]).processed
  end

   def pickuped_by?(user)
     pickups.exits?(user_id: user.id)
   end

end
