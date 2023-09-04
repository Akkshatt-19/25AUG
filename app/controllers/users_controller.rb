class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :login, :signup]


  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....." }
    end
  end

  def index
    render json: @current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :not_found
    end
  end

  def follow
    user = User.find(params[:id])
    current_user.followees << user
    render json: user
  end

  def unfollow
    user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: user.id).destroy
    render json: user
  end

  def show
    follower_ids = @current_user.followers.pluck(:follower_id)
    followee_ids = @current_user.followees.pluck(:followee_id)
    post_user_ids = (follower_ids + followee_ids + [@current_user.id]).uniq
    @posts = Post.where(user_id: post_user_ids)
    render json: @posts
  end

  def destroy
    @current_user.destroy
    render json: { message: 'User Deleted Successfully.' }
  end

  def signup
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.jwt_encode(user_id: user.id)
      render json: { message: "Signed Up Successfully.", token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :fname,
      :lname,
      :profile_picture
    )
  end
end
