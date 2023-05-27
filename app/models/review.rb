class Review < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :stars, dependent: :destroy
  has_many :hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts

  has_one_attached :review_image

  # DBへのコミット直前に実施する
  after_create do
    review = Review.find_by(id: id)
    # hashbodyに打ち込まれたハッシュタグを検出
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
        # ハッシュタグは先頭の#を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      review.hashtags << tag
    end
  end

  # 更新アクション
  before_update do
    review = Review.find_by(id: id)
    review.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      review.hashtags << tag
    end
  end

  # 平均点を算出し、round関数で切り上げ
  def average_rating
    stars.average(:score).to_f.round(1)
  end

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
