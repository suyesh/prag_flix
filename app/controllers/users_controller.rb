class UsersController < ApplicationController

	before_action :require_signin, except: [:new, :create]
	before_action :require_correct_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
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
		@reviews = @user.reviews
	end

	def edit
	end

	def update
		if @user.update(set_user_params)
			redirect_to user_path(@user), notice: "Account successfully Updated!"
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path, alert: "You have successfully deleted your account"
	end

	private

	def set_user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
	end

	def require_correct_user
		@user = User.find(params[:id])
		redirect_to root_url unless current_user?(@user)
	end

end
