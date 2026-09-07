class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: [:return_book]

  def index
    @borrowings = if current_user.admin?
                    Borrowing.includes(:user, :book).order(created_at: :desc)
                  else
                    current_user.borrowings.includes(:book).order(created_at: :desc)
                  end
    @borrowings = @borrowings.page(params[:page]).per(10)
  end

  def create
    @book = Book.find(params[:book_id])
    @borrowing = current_user.borrowings.new(book: @book)

    if @borrowing.save
      redirect_to @book, notice: "You have successfully borrowed \"#{@book.title}\"."
    else
      redirect_to @book, alert: @borrowing.errors.full_messages.to_sentence
    end
  end

  def return_book
    if current_user.admin? || @borrowing.user == current_user
      @borrowing.mark_returned!
      redirect_to borrowings_path, notice: "Book marked as returned."
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end
end
