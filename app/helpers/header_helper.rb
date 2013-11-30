module HeaderHelper
  def resource_active(*resources)
    "active" if resources.include?(controller_name)
  end
end
