class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #follower_id=自分
  #follow_id=相手
 # 自分がフォローしたり、アンフォローしたりするための記述
  has_many :relationships, class_name: "relationship", foreign_key: "follower_id", dependent: :destroy
 # sourceは本当はfollow_idとなっていてカラム名を示している。
 # フォロー一覧を表示するための記述
  has_many :followings, through: :favorites, source: :follow

  has_many :reverse_favorites, class_name: "relationship", foreign_key: "follow_id", dependent: :destroy
 # フォロワー一覧を表示するための記述
  has_many :followers, through: :reverse_relationships, source: :follower

  def follow(user_id)
    favorites.create(follow_id: user_id)
  end

  def unfollow(user_id)
    favorites.find_by(follow_id: user_id).destroy
  end

  has_one_attached :user_image

  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end

  # ユーザー名が3文字未満の場合はエラーを出すようにしたいが
  # TerminalでArugument Error（引数エラー）が発生する　↓
  # validates :name, presence: true, length: { minimum: 3 }
end
