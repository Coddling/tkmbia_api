module RoleHelper
  def is_event_assistant?
    status == 'event_assistant'
  end

  def is_manager?
    status == 'manager'
  end

  def is_admin?
    status == 'admin'
  end
end