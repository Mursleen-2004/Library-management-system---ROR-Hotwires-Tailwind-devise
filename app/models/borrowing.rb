class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :status, { borrowed: 0, returned: 1, overdue: 2 }

  validates :borrowed_at, :due_date, presence: true
  validate :book_must_be_available, on: :create
  validate :user_cannot_double_borrow, on: :create

  before_validation :set_borrowing_defaults, on: :create
  after_create :decrement_book_availability
  after_update :increment_book_availability, if: :saved_change_to_status_returned?

  scope :active, -> { where(status: :borrowed) }
  scope :overdue, -> { active.where("due_date < ?", Time.current) }

  def overdue?
    borrowed? && due_date < Time.current
  end

  def mark_returned!
    update(returned_at: Time.current, status: :returned)
  end

  private

  def set_borrowing_defaults
    self.borrowed_at ||= Time.current
    self.due_date ||= 14.days.from_now
  end

  def book_must_be_available
    return unless book

    errors.add(:book, "has no available copies") unless book.available?
  end

  def user_cannot_double_borrow
    return unless user && book

    if user.borrowings.active.where(book: book).exists?
      errors.add(:base, "You have already borrowed this book and not returned it yet")
    end
  end

  def decrement_book_availability
    book.decrement!(:available_copies)
  end

  def increment_book_availability
    book.increment!(:available_copies)
  end

  def saved_change_to_status_returned?
    saved_change_to_status? && returned?
  end
end
