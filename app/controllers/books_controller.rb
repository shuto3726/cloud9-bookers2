class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book)
  end
  
  def edit
    
  end
  
  def show
  end
  
  def index
  end
  
  def update
  end
  
  def destoroy
    book = Book.find(params[:id])
    book.destoroy
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
