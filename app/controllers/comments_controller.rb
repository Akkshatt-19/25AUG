class CommentsController < ApplicationController
  before_action :authenticate_request, only: [:create, :update, :destroy]
  before_action :set_post, only: [:index, :create]
  before_action :set_comment, only: [:update, :destroy, :edit]

  def index
    @comments = @post.comments
    render json: @comments
  end

  def update
    if @comment.user == @current_user # Check if the current user owns the comment
      if @comment.update(comment_params)
        render json: @comment, notice: 'Comment was successfully updated.'
      else
        render_error_response(@comment)
      end
    else
      render json: { error: 'You are not authorized to update this comment.' }, status: :unauthorized
    end
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user: @current_user))
    if @comment.save
      render json: @comment, status: :created
    else
      render_error_response(@comment)
    end
  end

  def destroy
    if @comment.user == @current_user # Check if the current user owns the comment
      if @comment
        @comment.destroy
        render json: 'Comment Deleted Successfully.'
      else
        render_not_found_response('Comment not found')
      end
    else
      render json: { error: 'You are not authorized to delete this comment.' }, status: :unauthorized
    end
  end

  def edit
    if @comment.user == @current_user # Check if the current user owns the comment
      render json: @comment
    else
      render json: { error: 'You are not authorized to edit this comment.' }, status: :unauthorized
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.permit(:content, :post_id)
  end

  def render_error_response(resource)
    render json: { error: resource.errors.full_messages }, status: :bad_request
  end

  def render_not_found_response(message)
    render json: { error: message }, status: :not_found
  end
end
