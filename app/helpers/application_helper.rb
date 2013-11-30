module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    @resource_class ||= devise_mapping.to
  end

  def t_attr(resource,attribute)
    I18n.t attribute , :scope => [:activerecord, :attributes, resource]
  end
end
