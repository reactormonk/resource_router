require 'resource_router/walker'
require 'resource_router/tree/abstract_node'
require 'resource_router/tree/string_node'
require 'resource_router/tree/root_node'

suite "ResourceRouter" do
  suite "Walker" do

    setup do
      @env = {
        'REQUEST_PATH' => '/make/me/a/sandwitch/',
        'HTTP_HOST'    => 'foo.bar.baz'
      }
    end

    exercise "a new Walker" do
      ResourceRouter::Walker.new(@env, nil)
    end
    verify "got an array of paths" do
      equal(returned.paths, [''] + %w(make me a sandwitch))
    end
    verify "got an array of domains" do
      equal(returned.domains, %w(foo bar baz))
    end

    suite "#recognize" do
      setup do
        @root_node = ResourceRouter::Tree::RootNode.new
      end
      setup :tree, "a very simple tree" do
        @target = ResourceRouter::Tree::StringNode.new("foo")
        @root_node.add_child(@target)
      end
      setup do
        @walker = ResourceRouter::Walker.new({'REQUEST_PATH' => '/foo', 'HTTP_HOST' => ''}, @root_node)
      end

      exercise "walk :tree" do
        @walker.recognize
      end
      verify "it reached :target" do
        equal(@target, returned.node)
      end
    end

  end
end
