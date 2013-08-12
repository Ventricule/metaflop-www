#
# metaflop - web interface
# © 2012 by alexis reigel
# www.metaflop.com
#
# licensed under gpl v3
#

require 'slim/logic_less'

# mixin for sinatra app
#
# provides a slim renderer that sets the template and view model from
# the views directory
#
# it can also be used for views that need to render a partial
module LogicLessSlim
  attr_reader :view_model

  # set the corresponding view model class to the slim view
  def slim(template, options = {})
    require "./views/#{template}"

    @view_model = "App::Views::#{template.to_s.camelize}".constantize.new

    # custom template set on class
    unless @view_model.class.template.nil?
      template = @view_model.class.template
    end

    # copy instance variables set in sinatra to the view
    instance_variables.each do |name|
      @view_model.instance_variable_set(name, instance_variable_get(name))
    end

    options.merge!(:dictionary => 'self.view_model')

    if respond_to? :render, true
      render :slim, template, options
    else
      require 'slim'
      require 'tilt'
      Tilt.new("./views/#{template}.slim", options).render(self)
    end
  end
end
