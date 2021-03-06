class BooksController < ApplicationController
before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook)
    else
      @user = current_user
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to book_path
    end
  end

  def index
    @user = current_user
    @newbook = Book.new
    @books = Book.all
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
       render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:notice] = "Book was successfully destroyed."

  end

  private
    def ensure_correct_user
      @book = Book.find(params[:id])
      if @book.user_id != current_user.id
        redirect_to books_path
      end
    end
    
    def book_params
      params.require(:book).permit(:title, :body)
    end

end
