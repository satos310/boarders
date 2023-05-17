class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_one :notification, as: :subject, dependent: :destroy
end
