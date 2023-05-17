class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザー名が3文字未満の場合はエラーを出すようにしたいが
  # TerminalでArugument Error（引数エラー）が発生する　↓

  # validates :name, presence: true, length: { minimum: 3 }
end
