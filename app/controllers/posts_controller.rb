class PostsController < ApplicationController
  def index
    @posts=Post.all
    render json: @posts
  end
  
  def create
    @posts = Post.new(post_params)
    if @posts.save
      render json: @posts, status: 201
    else
      render json: {error: @posts.errors.full_messages}, status: 400
    end
  end
  
  def update
    @posts = Post.find(params[:id])
    if @posts.update(post_params)
      render json: @posts,status: 200
    else
      render json: {error: @posts.errors.full_messages},status: 404
    end
  end
  
  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    render json:'Post Deleted Succesfully..'
  end
  
  private def post_params
    params.permit(
      :content,
      :image,
      :user_id
    )
  end
  
  def show
    @posts = Post.find(params[:id])
    if @posts
      render json: @posts
    else
      render json: {error: 'Post not found'},status: 400
    end
  end
  
end
