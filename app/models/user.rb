# frozen_string_literal: true

class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :sleep_records, dependent: :destroy
end
