class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
  	@books = Book.all
  	@book = Book.new
    @users = User.all
  end

  def new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @users = User.all
      render action: :index
    end
  end

  def edit
  	@book = Book.find(params[:id])
    if current_user.id == @book.user_id
    else redirect_to books_path
    end
  end

  def update
  	book = Book.find(params[:id])
  		if book.update(book_params)
  			redirect_to book_path(book.id), notice: "You have updated book successfully."
  		else
        @book = book
  			render action: :edit
  		end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private

  def book_params
  	params.require(:book).permit(:title,:body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
