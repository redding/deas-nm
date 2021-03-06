require 'assert'
require 'deas-nm'

require 'nm/source'
require 'deas/template_engine'

class Deas::Nm::TemplateEngine

  class UnitTests < Assert::Context
    desc "Deas::Nm::TemplateEngine"
    setup do
      @engine = Deas::Nm::TemplateEngine.new({
        'source_path' => TEST_SUPPORT_PATH,
        'ext'         => 'nm'
      })
    end
    subject{ @engine }

    should have_imeths :nm_source, :nm_handler_local, :nm_logger_local
    should have_imeths :nm_serializer
    should have_imeths :render, :partial, :compile

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

    should "pass any given cache option to the Nm source" do
      engine = Deas::Nm::TemplateEngine.new('cache' => true)
      assert_kind_of Hash, engine.nm_source.cache
    end

    should "pass any given ext option to the Nm source" do
      ext = Factory.string
      engine = Deas::Nm::TemplateEngine.new('ext' => ext)
      assert_equal ".#{ext}", engine.nm_source.ext
    end

    should "use 'logger' as the logger local name by default" do
      assert_equal 'logger', subject.nm_logger_local
    end

    should "allow custom logger local names" do
      logger_local = Factory.string
      engine = Deas::Nm::TemplateEngine.new('logger_local' => logger_local)
      assert_equal logger_local, engine.nm_logger_local
    end

    should "use a no-op serializer by default" do
      obj = Factory.integer
      assert_equal obj, subject.nm_serializer.call(obj, Factory.string)
    end

    should "not implement the engine compile method" do
      assert_raises NotImplementedError do
        subject.compile('_partial.json', Factory.text)
      end
    end

  end

end
