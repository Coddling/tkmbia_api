class AuthUserSerializer < BaseSerializer
  attributes :id, :email, :role, :human_role, :status

  def human_role
    AuthUser::ROLES_HUMANIZED[object.role]
  end
end