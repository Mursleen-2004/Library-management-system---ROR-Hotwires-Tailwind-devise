class AuthorsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.alphabetical.page(params[:page]).per(12)
  end

  def show
    @books = @author.books.includes(:category)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path, notice: "Author was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @author.update(author_params)
      redirect_to authors_path, notice: "Author was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @author.destroy
      redirect_to authors_path, notice: "Author was successfully deleted.", status: :see_other
    else
      redirect_to authors_path, alert: @author.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :bio)
  end
end
