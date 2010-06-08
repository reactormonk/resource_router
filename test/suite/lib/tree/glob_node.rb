require 'resource_router/tree/glob_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "GlobNode" do
      setup do
        @node_class = ResourceRouter::Tree::GlobNode
        @root_node = ResourceRouter::Tree::RootNode.new
      end

      exercise "GlobNode" do
        @node_class
      end
      verify "priority 0" do
        equal(0, returned.priority)
      end

      exercise "a new GlobNode" do
        @node_class.new(:key)
      end
      verify "it's got the key set" do
        equal(:key, returned.key)
      end

      suite "methods" do
        setup do
          @node = @node_class.new(:key)
          @runner = ResourceRouter::Runner.new(:node, %w(foo bar baz), %w())
        end

        exercise "#visit" do
          @node.visit(@runner)
        end
        verify "the paths got shifted" do
          equal(%w(bar baz), @runner.remaining_paths)
        end
        verify "returns the matched path" do
          equal(%w(foo))
        end

        exercise "#matches?" do
          @node.matches?(@runner)
        end
        verify "returns true" do
          equal(true)
        end

      end

      suite "integration" do
        setup do
          @node = @node_class.new(:key)
          @root_node.add_child(@node)
          @walker = ResourceRouter::Walker.new({'HTTP_HOST' => 'example.org', 'REQUEST_PATH' => '/foo/bar/baz'}, @root_node)
        end

        exercise "#recognize" do
          @walker.recognize
        end
        verify "it goes to the correct node" do
          equal(@node, returned.node)
        end
        then_verify "it holds the correct matched path" do
          equal(%w(foo bar baz), returned.variables.values.first)
        end

      end

    end
  end
end
