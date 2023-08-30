
class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user
  
    def login 
      @user = User.find_by(email: params[:email])  # Fix the typo in the attribute name
      if @user&.authenticate(params[:password])
        token = jwt_encode({user_id: @user.id})
        time = Time.now + 24.hours.to_i
        render json: {
          token: token,
          exp: time.strftime("%m-%d-%Y %H:%M"),
          username: @user.user_name  # Change "username" to "user_name" for consistency
        }, status: :ok 
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end