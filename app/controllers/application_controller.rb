class ApplicationController < ActionController::API
  
  before_action :authenticate_request
  before_action do
    ActiveStorage::Current.host = request.base_url
  end
  private
  def authenticate_request
    begin
      header = request.headers[ 'Authorization' ]
      header = header.split(" ").last if header
      decoded = JsonWebToken.jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError	=> e
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    end
    
    # rescue ActiveRecord::RecordNotFound
    #   render json: "No record found.."
  end
  
  def current_user
    @current_user
  end
  
  # rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  # def handle_exception
  #   render json: { error: 'Record not found' }
  # end
end