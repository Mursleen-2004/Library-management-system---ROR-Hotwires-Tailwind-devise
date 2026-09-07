class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.includes(:author, :category)
                 .search_by_keyword(params[:keyword])
                 .by_category(params[:category_id])
                 .by_author(params[:author_id])
                 .order(:title)
                 .page(params[:page]).per(9)

    @categories = Category.alphabetical
    @authors = Author.alphabetical
  end

  def show
    @already_borrowed = user_signed_in? && @book.borrowed_by?(current_user)
  end

  def new
    @book = Book.new
    load_form_collections
  end

  def create
    @book = Book.new(book_params)
    @book.available_copies ||= @book.total_copies

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      load_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_form_collections
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      load_form_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully deleted.", status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def load_form_collections
    @authors = Author.alphabetical
    @categories = Category.alphabetical
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :description, :published_year,
                                  :total_copies, :available_copies, :cover_image_url,
                                  :author_id, :category_id)
  end
end
