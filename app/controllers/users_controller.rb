class UsersController < ApplicationController 
  skip_before_action :authenticate_request, only: [:create,:login]
  before_action :find_user, only: [:show, :update, :destroy]
  
  
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.jwt_encode(user_id: user.id)
      render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: "Please Check your Email And Password....."}  
    end
  end
  
  def index
    @users=User.all
    render json: @users, status: :ok
  end
  
  def new
    @user=User.new
  end
  
  def create
    @user =User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: {error: @user.errors.full.messages}, status: 400
    end
  end
  
  def update
    
    if @current_user.update(user_params)
      render json: @current_user,status: 200
    else
      render json: {error: @current_user.errors.full_messages},status: 404
    end
  end
  
  def user_post
   
    follower_ids = @current_user.followers.pluck(:follower_id)
    followee_ids = @current_user.followees.pluck(:followee_id)
    post_user_ids = (follower_ids + followee_ids + [@current_user.id]).uniq
    @posts = Post.where(user_id: post_user_ids)
    render json: @posts
  end
  
  private def user_params
    params.permit(
    :email,
    :password,
    :fname,
    :lname
    )
  end
  
  def show
   
    if @current_user
      render json: @current_user
    else
      render json: @current_user.errors.full_messages
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json:'User Deleted Succesfully..'
  end
end
