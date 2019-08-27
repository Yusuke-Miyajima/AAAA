class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, {only:[:edit, :update]}
	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def index
		@users = User.all
		@user = current_user
		@book = Book.new
	end

  	def edit
  		@user = User.find(params[:id])
  	end

	def update
		@user = User.find(params[:id])
    	if @user.update(user_params)
    		redirect_to user_path(@user.id), notice: "You have updated successfully."
    	else
    		render action: :edit
    	end
	end

	private
	def correct_user
		user = User.find(params[:id])
		if current_user != user
			redirect_to user_path(current_user.id)
		end
	end

	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def book_params
		params.require(:book).permit(:title, :body)
	end
end