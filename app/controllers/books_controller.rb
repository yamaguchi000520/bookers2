class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] ="successfully"
      redirect_to book_path(@book)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end

  def index
    @book=Book.new
    @books=Book.all.order(created_at: :desc)
    @user=current_user
    @userc=@book.user
  end

  def show
    @book=Book.find(params[:id])
    @books=Book.all
    @user=@book.user
    @booknew=Book.new
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    flash[:notice] ="bookを削除しました"
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end