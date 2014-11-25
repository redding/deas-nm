require 'assert/factory'

module Factory
  extend Assert::Factory

  def self.template_json_rendered(engine, view_handler, locals)
    { 'thing' => {
        'id'     => view_handler.identifier,
        'name'   => view_handler.name,
        'local1' => locals['local1'],
        'logger' => engine.logger.to_s
      }
    }
  end

  def self.partial_json_rendered(engine, locals)
    { 'thing' => {
        'local1' => locals['local1'],
        'logger' => engine.logger.to_s
      }
    }
  end

  def self.template_partial_json_rendered(engine, view_handler, locals)
    { 'thing' => {
        'id'     => view_handler.identifier,
        'name'   => view_handler.name,
        'local1' => locals['local1'],
        'logger' => engine.logger.to_s
      },
      'partial' => {
        'thing' => {
          'local1' => locals['local1'],
          'logger' => engine.logger.to_s
        }
      }
    }
  end

end
