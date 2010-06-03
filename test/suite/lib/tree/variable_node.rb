require 'resource_router/tree/variable_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "VariableNode" do
      setup do
        @node_class = ResourceRouter::Tree::VariableNode
      end

      exercise "VariableNode" do
        @node_class
      end
      verify "priority 5" do
        equal(5, returned.priority)
      end

      exercise "a new VariableNode" do
        @node_class.new(:parent, :name)
      end
      verify "it's got the name set" do
        equal(:name, returned.name)
      end

      suite "methods" do
        setup do
          @node = @node_class.new(:parent, :name)
          @runner = ResourceRouter::Runner.new(:node, %w(foo bar baz), %w())
        end

        exercise "#visit" do
          @node.visit(@runner)
        end
        verify "the paths got shifted" do
          equal(%w(bar baz), @runner.remaining_paths)
        end
        verify "returns the matched path" do
          equal("foo")
        end


        exercise "#matches?" do
          @node.matches?(@runner)
        end
        verify "returns true" do
          equal(true)
        end

      end
    end
  end
end
