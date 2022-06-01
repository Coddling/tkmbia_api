class Api::V1::AuthController < ApplicationController
  before_action :validate_authenticate, only: %i[me sign_out]

  def sign_in
    get_resource(
      AuthUser,
      'email',
      params[:email],
      'Invalid Credentials, please try again!',
      ExceptionHandler::UnauthorizedError
    )
    raise_unauthorized('This account has been deactivated, please contact the administrator') and return if @resource.inactive?
    raise_unauthorized('Invalid Credentials, please try again!') and return if @resource.nil?
    raise_unauthorized('Invalid Credentials, please try again!') and return unless @resource.authenticate(params[:password])
    new_token = encode({
      user: {
        id: @resource.id,
        role: @resource.role
      }
    })
    @resource.update!(token: new_token)
    user = @resource.user
    success_response(
      {
        tokens: {
          access_token: new_token,
        },
        user: {
          **(serialize(UserSerializer, user) || {}),
          **serialize(AuthUserSerializer, @resource)
        },
        
      }, 
      "Bienvenido!!!"
    )
  end

  def sign_out
    @auth_user.update(token: nil)
    success_response
  end

  def me
    user = User.find_by(id: @current_user.id)
    success_serialized_response(UserSerializer, user)
  end
end
