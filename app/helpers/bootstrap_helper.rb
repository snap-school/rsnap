module BootstrapHelper
  def button(name=nil, options={}, html_options={:class => "", :type => :default}, &block)
    html_options[:class] = "btn btn-#{html_options[:type]} #{html_options[:class]}"
    html_options.delete(:type)
    link_to name, options, html_options, &block
  end
end
