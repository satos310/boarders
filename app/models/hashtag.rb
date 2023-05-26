class Hashtag < ApplicationRecord
    validates :hashname, presence: true, length: { maximum: 50 }
    has_many :hashtag_relations, dependent: :destroy
    has_many :reviews, through: :hashtag_posts
end
