class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 追加
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :pickuped_reviews, through: :pickups, source: :review
  # has_many :notifications, dependent: :destroy

  #follower_id=自分
  #follow_id=相手
 # 自分がフォローしたり、アンフォローしたりするための記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

 # sourceは本当はfollow_idとなっていてカラム名を示している。
 # フォロー一覧を表示するための記述
  has_many :followings, through: :relationships, source: :follow

  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
 # フォロワー一覧を表示するための記述
  has_many :followers, through: :reverse_relationships, source: :follower

  def follow(user_id)
    relationships.create(follow_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(follow_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # pickupsテーブルにreview_idが存在しているかどうか検索をかけている
  def pickuped_by?(review_id)
    pickups.where(review_id: review_id).exists?
  end

  has_one_attached :user_image

  # ログイン時にemail/nameでできるようにした際に追加
  # def login
  #   @login || self.name || self.email
  # end

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if (login = conditions.delete(:login))
  #     where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   elsif conditions.has_key?(:name) || conditions.has_key?(:email)
  #     where(conditions.to_h).first
  #   end
  # end

  # def validate_name
  #   if User.where(email: name).exists?
  #     errors.add(:name, :invalid)
  #   end
  # end

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
