class UsersController < ApplicationController

	before_action :require_signin, except: [:new, :create]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(set_user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "You have successfully Signed Up. Welcome!!"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(set_user_params)
			redirect_to user_path(@user), notice: "Account successfully Updated!"
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		session[:user_id] = nil
		redirect_to root_path, alert: "You have successfully deleted your account"
	end

	private

	def set_user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
	end

end
