require 'deas/template_engine'
require 'nm'
require "deas-nm/version"

module Deas::Nm

  class TemplateEngine < Deas::TemplateEngine

    DEFAULT_HANDLER_LOCAL = 'view'.freeze
    DEFAULT_SERIALIZER = proc{ |obj, template_name| obj }.freeze # no-op

    def nm_source
      @nm_source ||= Nm::Source.new(self.source_path)
    end

    def nm_handler_local
      @nm_handler_local ||= (self.opts['handler_local'] || DEFAULT_HANDLER_LOCAL)
    end

    def nm_serializer
      @nm_serializer ||= (self.opts['serializer'] || DEFAULT_SERIALIZER)
    end

    def render(template_name, view_handler, locals)
      self.nm_serializer.call(
        self.nm_source.render(template_name, render_locals(view_handler, locals)),
        template_name
      )
    end

    def partial(template_name, locals)
      self.nm_serializer.call(
        self.nm_source.render(template_name, locals),
        template_name
      )
    end

    def capture_partial(template_name, locals, &content)
      raise NotImplementedError
    end

    private

    def render_locals(view_handler, locals)
      { self.nm_handler_local => view_handler }.merge(locals)
    end

  end

end
