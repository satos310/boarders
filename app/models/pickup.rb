class Pickup < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :subject, dependent: :destroy
  
  validates_uniqueness_of :review_id, scope: :user_id
  
end
