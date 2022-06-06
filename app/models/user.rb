class User < ApplicationRecord
  include AASM
  include RoleHelper

  validates_presence_of :full_name
  validates_uniqueness_of :auth_user_id

  belongs_to :auth_user

  scope :active_users, -> { where(status: 'active') }
  scope :order_by_created_at, -> { order('created_at desc') }

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