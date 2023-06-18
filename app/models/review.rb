class Review < ApplicationRecord
  belongs_to :user
  has_many :comments,   dependent: :destroy
  has_many :pickups,    dependent: :destroy
  has_many :stars,      dependent: :destroy
  has_many :post_tags,  dependent: :destroy
  has_many :hashtags,   through: :post_tags
  has_many :reviewd_users, through: :reviews, source: :user

  has_one_attached :review_image

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 250 }

  def self.search(search)
    if search != ""
      Review.where(['title LIKE(?) OR body LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Review.includes(:user).order('created_at DESC')
    end
  end

  def save_hashtag(sent_hashtags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_hashtags = self.hashtags.pluck(:name) unless self.hashtags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_hashtags = current_hashtags - sent_hashtags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_hashtags = sent_hashtags - current_hashtags

    # 古いタグを消す
    old_hashtags.each do |old|
      self.hashtags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_hashtags.each do |new|
      new_review_hashtag = Hashtag.find_or_create_by(name: new)
      self.hashtags << new_review_hashtag
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
