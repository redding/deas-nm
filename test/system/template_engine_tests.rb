require 'assert'
require 'deas-nm'

class Deas::Nm::TemplateEngine

  class SystemTests < Assert::Context
    desc "Deas::Nm::TemplateEngine"
    setup do
      @view = OpenStruct.new({
        :identifier => Factory.integer,
        :name => Factory.string
      })
      @locals = { 'local1' => Factory.string }

      @engine = Deas::Nm::TemplateEngine.new({
        'source_path' => TEST_SUPPORT_PATH,
        'ext'         => 'nm',
        'serializer'  => proc{ |obj, template_name| obj.to_s }
      })
    end
    subject{ @engine }

    should "render nm template files and serialize them" do
      exp = Factory.template_json_rendered(subject, @view, @locals).to_s
      assert_equal exp, subject.render('template.json', @view, @locals)
    end

    should "render nm partials and serialize them" do
      exp = Factory.partial_json_rendered(subject, @locals).to_s
      assert_equal exp, subject.partial('_partial.json', @locals)
    end

    should "render nm templates that render partials and serialize them" do
      exp = Factory.template_partial_json_rendered(subject, @view, @locals).to_s
      assert_equal exp, subject.render('template_partial.json', @view, @locals)
    end

  end

end
