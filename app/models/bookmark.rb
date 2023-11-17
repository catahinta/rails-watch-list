class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :comment, length: { minimum: 6, maximum: 25 }, presence: true
  validates :movie, :list, presence: true
  validates :movie, uniqueness: { scope: :list }
end
