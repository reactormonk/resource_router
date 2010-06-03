require 'resource_router/runner'
suite "ResourceRouter" do
  suite "Runner" do

    setup do
      @runner = ResourceRouter::Runner.new(:node, [""] + %w(make me a sandwitch), %w(foo bar baz), {:foo => :bar})
    end

    exercise "a new Runner" do
      @runner
    end
    verify "#remaining_paths" do
      equal([""] + %w(make me a sandwitch), returned.remaining_paths)
    end
    verify "#remaining_domains" do
      equal(%w(foo bar baz), returned.remaining_domains)
    end
    verify "#variables" do
      kind_of(Hash, returned.variables)
    end
    verify "#node" do
      equal(:node, returned.node)
    end

    exercise "#dup" do
      @runner.dup
    end
    verify "doesn't dup @node" do
      returned.node.equal? :node
    end
    verify "dups @remaining_paths" do
      ! returned.remaining_paths.equal? @runner.remaining_paths
    end
    verify "dups @remaining_domains" do
      ! returned.remaining_domains.equal? @runner.remaining_domains
    end
    verify "dups @variables" do
      ! returned.variables.equal? @runner.variables
    end

    suite "#run" do
      setup :example, "String/Variable" do
        # copy/pasted from :node_set
        @nodes = [
          ResourceRouter::Tree::StringNode.new(:parent, "bar"),
          ResourceRouter::Tree::StringNode.new(:parent, "foo"),
          ResourceRouter::Tree::VariableNode.new(:parent, :baz)
        ]
        @children = [@nodes[2]]
        @child = @nodes[1]
      end

      setup :example, "Variable" do
        @nodes = [
          ResourceRouter::Tree::StringNode.new(:parent, "bar"),
          ResourceRouter::Tree::VariableNode.new(:parent, :baz)
        ]
        @children = []
        @child = @nodes[1]
      end

      setup do
        @basic_node = ResourceRouter::Tree::VariableNode.new(:parent, :baz)
        @variables = {:baz => "baz"}
        @nodes.each {|node| @basic_node.add_child(node)}
        @runner = ResourceRouter::Runner.new(@basic_node, %w(baz foo bar), %w(example org))
      end

      exercise "run!" do
        @runner.run
      end
      verify "sets the variable" do
        equal(@variables, @runner.variables)
      end
      verify "sets itself to the next child" do
        equal(@child, @runner.node)
      end
      verify "returns the remaining children" do
        equal_unordered(@children, returned)
      end
    end

  end
end
