class AuthUser < ApplicationRecord
  include AASM
  include RoleHelper

  VALID_ROLES = %w[admin manager event_assistant]

  ROLES_HUMANIZED = {
    'admin' => 'Administrador',
    'manager' => 'Manager',
    'event_assistant' => 'Asistente al evento',
  }

  has_one :user
  has_secure_password
  validates_presence_of :role
  validates_presence_of :password, on: :create

  validates_inclusion_of :role, in: VALID_ROLES
  validates_format_of :email, :with => URI::MailTo::EMAIL_REGEXP

  aasm(:status) do
    state :active, initial: true
    state :inactive

    event :inactivate do
      transitions from: :active, to: :inactive
    end

    event :activate do
      transitions from: :inactive, to: :active
    end
  end
end