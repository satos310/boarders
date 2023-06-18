class Star < ApplicationRecord
  belongs_to :review
  validates :score, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5,
    message: 'を入力してください。'
  }
end
