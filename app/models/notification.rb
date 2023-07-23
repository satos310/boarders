# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :pickups, dependent: :destroy
end
