class Hashtag < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    has_many :post_tags, dependent: :destroy, foreign_key: 'hashtag_id'
    has_many :reviews, through: :post_tags

end
