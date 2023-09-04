class FollowsController < ApplicationController
  before_action :authenticate_request, only: [:create, :destroy]

  def index
    follows = Follow.all
    render json: follows
  end

  def create
    follow = Follow.new(follow_params)
    if follow.save
      render json: follow, status: :created
    else
      render_error_response(follow, :bad_request)
    end
  end

  def show
    follow = Follow.find_by(id: params[:id])
    if follow
      render json: follow
    else
      render_not_found_response('Follow not found')
    end
  end

  def destroy
    follow = @current_user.follows.find_by(id: params[:id])
    if follow
      follow.destroy
      render json: 'Follower Deleted Successfully.'
    else
      render_not_found_response('Follow not found')
    end
  end

  private

  def follow_params
    params.permit(:follower_id, :followee_id)
  end

  def render_error_response(resource, status = :bad_request)
    render json: { error: resource.errors.full_messages }, status: status
  end

  def render_not_found_response(message)
    render json: { error: message }, status: :not_found
  end
end
