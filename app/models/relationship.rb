# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follow, class_name: "User"
  belongs_to :follower, class_name: "User"

  # has_one :notification, as: :subject, dependent: :destroy
end
