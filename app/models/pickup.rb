class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :subject, dependent: :destroy

  # post_idとuser_id　の組は1組しかできないようにしている
  validates_uniqueness_of :review_id, scope: :user_id

end
