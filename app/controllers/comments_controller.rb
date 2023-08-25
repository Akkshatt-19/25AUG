class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:index]
  def index
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end
  
  def update
    if @comment.update(comment_params)
      render json: @comment, notice: 'Comment was successfully updated.'
    else
      render json: {error: @comments.errors.full_messages},status: 404
    end
  end
  
  def create
    @comments = Comment.new(comment_params)
    if @comments.save
      render json: @comments, status: 201
    else
      render json: {error: @comments.errors.full_messages}, status: 400
    end
  end
  
  def destroy
    post = @comment.post
    @comment.destroy
    render json:'Comment Deleted Succesfully..'
  end
  
  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def comment_params
    params.permit(
      :content,
      :user_id,
      :post_id
    )
  end
  
end