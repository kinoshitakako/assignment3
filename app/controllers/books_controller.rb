class BooksController < ApplicationController


  def show
    @book_=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully"
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = current_user
    render :index
    end
  end

  def edit
    book = Book.find(params[:id])
    if book.user == current_user
       @book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def destroy
    book= Book.find(params[:id])
    if book.user == current_user
    book.destroy
    end
    redirect_to books_path
  end

  def update
    book = Book.find(params[:id])
    if book.user == current_user
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to book_path(@book.id), notice: "You have updated book successfully"
        else
            render :edit
        end
    end
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
