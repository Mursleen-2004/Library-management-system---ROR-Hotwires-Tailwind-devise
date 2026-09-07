class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @total_books = Book.count
    @total_copies = Book.sum(:total_copies)
    @total_users = User.count
    @active_borrowings = Borrowing.active.count
    @overdue_borrowings = Borrowing.overdue.count
    @recent_borrowings = Borrowing.includes(:user, :book).order(created_at: :desc).limit(5)
    @popular_books = Book.left_joins(:borrowings)
                          .group(:id)
                          .order(Arel.sql("COUNT(borrowings.id) DESC"))
                          .limit(5)
  end
end
