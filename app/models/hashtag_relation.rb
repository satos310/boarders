class HashtagRelation < ApplicationRecord
  belongs_to :review
  belongs_to :hashtag
  validates :review_id, presence: true
  validates :hashtag_id, presence: true
end
