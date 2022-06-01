class ApplicationController < ActionController::API
  include ModelHelper
  include RenderHelper
  include AuthHelper
  include ExceptionHandler::ApiException

  def validate_authenticate
    extract_jwt_content
    @current_user = User.find_by(auth_user_id: @auth_user['id'])
    raise_unauthorized('Invalid session, please login again') if @current_user.nil?
    raise_unauthorized('This account has been deactivated, please contact the administrator') and return if @current_user.inactive?
    @auth_user = @current_user.auth_user
    raise_unauthorized('Invalid Credentials, please try again!') and return if @auth_user.nil?
    raise_unauthorized('Invalid Credentials, please try again!') if @auth_user.token != http_auth_header
  end
  
  def extract_jwt_content
    @auth_user = decode(http_auth_header)['user']
    raise_unauthorized('Invalid session, please login again') if @auth_user.nil?
    raise_unauthorized('Invalid session, please login again') if @auth_user['id'].nil? or @auth_user['role'].nil?
    return @auth_user
  rescue => _
    raise_unauthorized('Invalid session, please login again')
  end

  def http_auth_header
    headers = request.headers
    return headers['Authorization'].split.last if headers['Authorization'].present?
    raise_unauthorized('Invalid session, please login again')
  end

end
