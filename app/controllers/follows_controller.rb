class FollowsController < ApplicationController
  
  def post
    @follows = Follow.new(follow_params)
    if @follows.save
      render json: @follows, status: 201
    else
      render json: {error: @follows.errors.full_messages}, status: 400
    end
  end
  
  def index
    @follows=Follow.all
    render json: @follows
  end
  
  
  def show
    @follows = Follow.find(params[:id])
    if @follows
      render json: @follows
    else
      render json: {error: 'Follower not found'},status: 400
    end
  end
  
  def destroy
    @follows = Follow.find(params[:id])
    @follows.destroy
    render json:'Follower Deleted Succesfully..'
  end
  
  private def follow_params
    params.permit(
      :follower_id,
      :followee_id
    )
  end
  
end
