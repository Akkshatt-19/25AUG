class BlocksController < ApplicationController
  before_action :authenticate_request, only: [:create, :destroy]
  
  def create
    user = User.find(params[:id])
    @current_user.blockeds << user
    render json: 'User Block Successfully.'
  end
  
  def destroy
    block = @current_user.blockeds.find_by(id: params[:id])
    if block
      block.destroy
      render json: 'User Unblock Successfully.'
    else
      render_not_found_response('Block not found')
    end
  end
  
  private
  
  def block_params
    params.permit(:blocked_user_id)
  end
  
  def render_error_response(resource, status = :bad_request)
    render json: { error: resource.errors.full_messages }, status: status
  end
  
  def render_not_found_response(message)
    render json: { error: message }, status: :not_found
  end
end
