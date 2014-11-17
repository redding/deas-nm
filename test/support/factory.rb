require 'assert/factory'

module Factory
  extend Assert::Factory

  def self.template_json_rendered(view_handler, locals)
    { 'thing' => {
        'id'     => view_handler.identifier,
        'name'   => view_handler.name,
        'local1' => locals['local1']
      }
    }
  end

  def self.partial_json_rendered(locals)
    { 'thing' => {
        'local1' => locals['local1']
      }
    }
  end

end
