class Hashtag < ApplicationRecord
    validates :hashname, presence: true, length: { maximum: 50 }
    has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
    has_many :reviews, through: :post_tags

    validates :name, uniqueness: true, presence: true
end
