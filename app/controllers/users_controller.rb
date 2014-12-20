class UsersController < ApplicationController
	before_action :signed_in_user,
				only: [:index, :edit, :update, :destroy, :following, :followers]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

  def index
  	@users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
  	@user = User.new
  end

  def create
	@user = User.new(user_params)
	if @user.save
		users = User.all
		user = @user
		followed_users = []
		followers = []
		users.each do |follow|
			unless @user.id == follow.id
				if @user.labo == follow.labo
					followed_users << follow
					followers << follow
				end
			end
		end
		
		followed_users.each { |followed| user.follow!(followed) }
		followers.each { |follower| follower.follow!(user) }
		sign_in @user
		redirect_to root_url
	else
		render 'new'
	end
  end

  def edit

  end

  def update
	if @user.update_attributes(user_params)
		flash[:success] = "プロフィールを更新しました"
		redirect_to root_url
	else
		render 'edit'
	end
  end

  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User destroyed."
	redirect_to users_url
  end

  def admin_user
	redirect_to(root_path) unless current_user.admin?
  end

  def following
	@title = "Following"
	@user = User.find(params[:id])
	@users = @user.followed_users.paginate(page: params[:page])
	render 'show_follow'
  end
  
  def followers
	@title = "Followers"
	@user = User.find(params[:id])
	@users = @user.followers.paginate(page: params[:page])
	render 'show_follow'
  end

  private

	def user_params
		params.require(:user).permit(:name, :student_id, :email, :labo, :profile, :password,
									 :password_confirmation)
	end

	# Before actions
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "ログインしてください"
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
end
