# Deas::Nm

[Deas](https://github.com/redding/deas) template engine for rendering [Nm](https://github.com/redding/nm) templates

## Usage

Register the engine:

```ruby
require 'deas'
require 'deas-nm'

Deas.configure do |c|

  c.template_source "/path/to/templates" do |s|
    s.engine 'nm', Deas::Nm::TemplateEngine
  end

end
```

Add `.nm` to any template files in your template source path.  Deas will render their content using Nm when they are rendered.

### Serialization

Nm doesn't serialize the objects it renders - it just returns them.  However, Deas expects serialized body content.  By default, the rendered objects are not serialized.

To serialize the rendered objects, specify a serializer when registering:

```ruby
# this uses Oj to serialize to JSON (for example)
c.template_source "/path/to/templates" do |s|
  s.engine('nm', Deas::Nm::TemplateEngine, {
    'serializer' => proc{ |obj, template_name| Oj.dump(obj, :mode => :strict) }
  })
end
```

The template name is passed to any serializer proc.  This can be helpful if choosing how to serialize is conditonal upon the template name.  For example:

```ruby
c.template_source "/path/to/templates" do |s|
  s.engine('nm', Deas::Nm::TemplateEngine, {
    'serializer' => proc do |obj, template_name|
      if File.extname(template_name) == '.json'
        Oj.dump(obj, :mode => :strict)
      else
        # serialize some other way?
      end
    end
  })
end
```

### Notes

Nm doesn't allow overriding the template scope but instead allows you to pass in data that binds to the template scope as local methods.  By default, the view handler will be bound to Nm's scope via the `view` method in templates.  If you want to change this, provide a `'handler_local'` option when registering:

```ruby
c.template_source "/path/to/templates" do |s|
  s.engine 'nm', Deas::Nm::TemplateEngine, 'handler_local' => 'view_handler'
end
```

Nm doesn't cache templates by default.  To enable caching, pass a `'cache'` option when registering:

```ruby
  c.template_source "/path/to/templates" do |s|
    s.engine 'nm', Deas::Nm::TemplateEngine, 'cache' => true
  end
```

## Installation

Add this line to your application's Gemfile:

    gem 'deas-nm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deas-nm

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
