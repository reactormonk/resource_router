BareTest.new_component :node_set do
  exercise "a new :node_set_class" do
    ResourceRouter::Tree::NodeSet::AbstractNodeSet.new
  end
  verify "got children (Array)" do
    kind_of(Array, returned.children)
  end
  verify "got an optimize callback" do
    returned.respond_to?(:optimize)
  end
  verify "got a #find_children" do
    returned.respond_to?(:find_children)
  end

  suite "#find_children" do
    setup do
      @node_set = @node_set_class.new
    end
    setup :example, "a simple example" do
      @nodes = [
        ResourceRouter::Tree::StringNode.new("bar"),
        ResourceRouter::Tree::StringNode.new("foo"),
        ResourceRouter::Tree::VariableNode.new(:baz)
      ]
      @node_set.children.replace(@nodes)
      @runner = ResourceRouter::Runner.new(:node, %w(foo bar), %w(example org))
      @children = @nodes[1..2]
    end
    exercise "find!" do
      @node_set.find_children(@runner)
    end
    verify "find the correct children for :example" do
      equal(@children)
    end
  end

end
