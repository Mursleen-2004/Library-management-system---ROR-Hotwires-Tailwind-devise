class Author < ApplicationRecord
  has_many :books, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  scope :alphabetical, -> { order(:name) }
end
