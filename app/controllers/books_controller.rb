class BooksController < ApplicationController
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    @book.save
    flash[:notice] ="投稿が成功しました"
    redirect_to books_path
  end

  def index
    @book=Book.new
    @books=Book.all
    @user=@book.user
  end

  def show
    @book=Book.find(params[:id])
    @books=Book.all
    @user=@book.user
  end

  def destroy
    @book=Book.find(params[:id])
    @post_image.destroy
    redirect_to 'users_path'
  end

  def edit
    @book=Book.find(params[:id])
    @user=@book.user
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
