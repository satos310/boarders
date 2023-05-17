class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :pickups, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :user_image

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  # ユーザー名が3文字未満の場合はエラーを出すようにしたいが
  # TerminalでArugument Error（引数エラー）が発生する　↓

  # validates :name, presence: true, length: { minimum: 3 }
end
