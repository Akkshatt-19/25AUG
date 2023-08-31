class PostsController < ApplicationController
  def index
    @posts=Post.all
    render json: @posts
  end
  
  def create
    @posts = @current_user.posts.new(post_params)
    if @posts.save
      render json: @posts, status: 201
    else
      render json: {error: @posts.errors.full_messages}, status: 400
    end
  end
  
  def update
    @posts = @current_user.posts.find(params[:id])
    if @posts.update(post_params)
      render json: @posts,status: 200
    else
      render json: {error: @posts.errors.full_messages},status: 404
    end
  end
  
  def destroy
    @posts = @current_user.posts.find(params[:id])
    @posts.destroy
    render json:'Post Deleted Succesfully..'
  end

  def show
    @posts = @current_user.posts.find(params[:id])
    if @posts
      render json: @posts
    end
  rescue ActiveRecord::RecordNotFound
    render json: e.message
  end
  
  private def post_params
    params.permit(
      :content,
      :image,
      :user_id
    )
  end
end
