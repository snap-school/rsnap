module HeaderHelper
  def resources_active(*resources)
    "active" if resources.include?(controller_name)
  end

  def actions_active(resource, *actions)
    "active" if resource == controller_name && actions.include?(action_name)
  end
end
