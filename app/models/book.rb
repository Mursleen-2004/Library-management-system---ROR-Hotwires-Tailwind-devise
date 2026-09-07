class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :borrowings, dependent: :destroy
  has_many :borrowers, through: :borrowings, source: :user

  validates :title, presence: true
  validates :isbn, uniqueness: true, allow_blank: true
  validates :total_copies, numericality: { greater_than_or_equal_to: 0 }
  validates :available_copies, numericality: { greater_than_or_equal_to: 0 }
  validate :available_copies_not_greater_than_total

  scope :search_by_keyword, ->(keyword) {
    where("title ILIKE :k OR isbn ILIKE :k", k: "%#{keyword}%")
  }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :by_author, ->(author_id) { where(author_id: author_id) if author_id.present? }

  def available?
    available_copies > 0
  end

  def borrowed_by?(user)
    borrowings.where(user: user, status: :borrowed).exists?
  end

  private

  def available_copies_not_greater_than_total
    return if total_copies.nil? || available_copies.nil?

    if available_copies > total_copies
      errors.add(:available_copies, "can't be greater than total copies")
    end
  end
end
