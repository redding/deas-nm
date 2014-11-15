require 'assert'
require 'deas-nm'

require 'nm/source'
require 'deas/template_engine'

class Deas::Nm::TemplateEngine

  class UnitTests < Assert::Context
    desc "Deas::Nm::TemplateEngine"
    setup do
      @engine = Deas::Nm::TemplateEngine.new({
        'source_path' => TEST_SUPPORT_PATH
      })
    end
    subject{ @engine }

    should have_imeths :nm_source, :nm_handler_local
    should have_imeths :render, :partial, :capture_partial

    should "be a Deas template engine" do
      assert_kind_of Deas::TemplateEngine, subject
    end

    should "memoize its Nm source" do
      assert_kind_of Nm::Source, subject.nm_source
      assert_equal subject.source_path, subject.nm_source.root
      assert_same subject.nm_source, subject.nm_source
    end

    should "use 'view' as the handler local name by default" do
      assert_equal 'view', subject.nm_handler_local
    end

    should "allow custom handler local names" do
      handler_local = Factory.string
      engine = Deas::Nm::TemplateEngine.new('handler_local' => handler_local)
      assert_equal handler_local, engine.nm_handler_local
    end

    should "render nm template files" do
      view_handler = OpenStruct.new({
        :identifier => Factory.integer,
        :name => Factory.string
      })
      locals = { 'local1' => Factory.string }
      exp = Factory.template_json_rendered(view_handler, locals)

      assert_equal exp, subject.render('template.json', view_handler, locals)
    end

    should "render nm partials" do
      locals = { 'local1' => Factory.string }
      exp = Factory.partial_json_rendered(locals)

      assert_equal exp, subject.partial('_partial.json', locals)
    end

    should "not implement the engine capture partial method" do
      assert_raises NotImplementedError do
        subject.capture_partial('_partial.json', {})
      end
    end

  end

end
