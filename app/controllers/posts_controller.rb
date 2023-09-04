class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    render json: @current_user.posts
  end
  
  def create
    posts = @current_user.posts.new(post_params)
    if posts.save
      render json: posts, status: 201
    else
      render json: {error: posts.errors.full_messages}, status: 400
    end
  end

  def update
    if @post && @post.user == @current_user
      if @post.update(post_params)
        render json: @post, status: :ok
      else
        render json: { errors: @post.errors.full_messages }, status: :bad_request
      end
    else
      render json: { error: "Post not found or unauthorized" }, status: :not_found
    end
  end
 
  def destroy
    if @post && @post.user == @current_user
      @post.destroy
      render json: 'Post Deleted Successfully.'
    else
      render json: { error: "Post not found or unauthorized" }, status: :not_found
    end
  end

  def show
    render json: @post
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(
      :content,
      :image,
      :user_id
    )
  end
end
