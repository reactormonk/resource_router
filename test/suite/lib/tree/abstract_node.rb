require 'resource_router/tree/abstract_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "AbstractNode" do

      exercise "a new AbstractNode" do
        ResourceRouter::Tree::AbstractNode.new(:parent)
      end
      verify "got its parent set" do
        equal(:parent, returned.parent)
      end
      verify "got a NodeSet attached" do
        kind_of(ResourceRouter::Tree::NodeSet::AbstractNodeSet, returned.node_set)
      end

    end
  end
end
