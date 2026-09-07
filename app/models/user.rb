class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum :role, { member: 0, admin: 1 }

  has_many :borrowings, dependent: :destroy
  has_many :borrowed_books, through: :borrowings, source: :book

  validates :name, presence: true

  def active_borrowings
    borrowings.where(status: :borrowed)
  end

  def overdue_borrowings
    borrowings.where(status: :borrowed).where("due_date < ?", Time.current)
  end
end
