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

  def t(resource)
    I18n.t resource
  end

  def t_attr(resource,attribute)
    I18n.t attribute , :scope => [:activerecord, :attributes, resource]
  end

  def t_model(model)
    I18n.t model , :scope => [:activerecord, :models]
  end
end
