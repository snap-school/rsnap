module ApplicationHelper
  def t_attr(resource, attribute)
    I18n.t attribute , :scope => [:activerecord, :attributes, resource]
  end
end
