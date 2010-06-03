require 'resource_router/tree/string_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "StringNode" do
      setup do
        @node_class = ResourceRouter::Tree::StringNode
      end

      exercise "StringNode" do
        @node_class
      end
      verify "priority 7" do
        equal(7, returned.priority)
      end

      exercise "a new StringNode" do
        @node_class.new(:parent, :string)
      end
      verify "it's got the string set" do
        equal(:string, returned.string)
      end

      suite "methods" do
        setup do
          @node = @node_class.new(:parent, "foo")
          @runner = ResourceRouter::Runner.new(:node, %w(foo bar baz), %w())
        end

        exercise "#visit" do
          @node.visit(@runner)
        end
        verify "the paths got shifted" do
          equal(%w(bar baz), @runner.remaining_paths)
        end

        suite "#matches?" do

          setup :runner, "a matching" do
            @matches = true
          end
          setup :runner, "a not matching" do
            @runner.remaining_paths.shift
            @matches = false
          end

          exercise "#matches?" do
            @node.matches?(@runner)
          end
          verify "" do
            equal(@matches)
          end

        end
      end
    end
  end
end
