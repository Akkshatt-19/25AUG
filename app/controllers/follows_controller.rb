class FollowsController < ApplicationController
  
  def index
    @follows = Follow.all
    render json: @follows
  end
  
  def show
    @follows = @current_user.follows.find(params[:id])
    if @follows
      render json: @follows
    else
      render json: {error: 'Follower not found'},status: 400
    end
  end
  
  def destroy
    @follows = @current_user.follows.find(params[:id])
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
