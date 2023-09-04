class BlocksController < ApplicationController
    before_action :authenticate_request, only: [:create, :destroy]
  
    def create
      block = Block.new(block_params)
      block.user = @current_user
      if block.save
        render json: block, status: :created
      else
        render_error_response(block, :bad_request)
      end
    end
  
    def destroy
      block = @current_user.blocks.find_by(id: params[:id])
      if block
        block.destroy
        render json: 'Block Removed Successfully.'
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
  