class UsersController < ApplicationController
  def index
    @users=User.all
    render json: @users
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user,status: 200
    else
      render json: {error: @user.errors.full_messages},status: 404
    end
  end
  
  def user_post
    @user=User.find(params[:id])
    follower_ids = @user.followers.pluck(:follower_id)
    followee_ids = @user.followees.pluck(:followee_id)
    post_user_ids = (follower_ids + followee_ids + [@user.id]).uniq
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
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render json: {error: 'User not found'},status: 400
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json:'User Deleted Succesfully..'
  end
end
