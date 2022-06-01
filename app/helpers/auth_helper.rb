require 'jwt'

module AuthHelper

  def encode(payload)
    JWT.encode payload, hmac_secret, 'HS256'
  end

  def decode(token)
    JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })[0]
  end

  def hmac_secret
    'my$ecretK3y'
  end

  def admin_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.admin?
  end
  
  def radicator_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.radicator?
  end

  def entity_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.entity? && !@current_user.entities.count.zero?
  end
  
  def lawyer_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.lawyer?
  end

  def approver_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.approver?
  end

  def claimant_role_verification
    raise_forbidden('Parece que no tienes permisos para realizar esta acción') unless @current_user.claimant?
  end
end