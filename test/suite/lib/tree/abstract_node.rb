require 'resource_router/tree/abstract_node'
require 'resource_router/tree/node_set/abstract'
suite "ResourceRouter" do
  suite "Tree" do
    suite "AbstractNode" do

      setup do
        ResourceRouter::Tree::AbstractNode.node_set = ResourceRouter::Tree::NodeSet::Abstract
      end

      exercise "a new AbstractNode" do
        ResourceRouter::Tree::AbstractNode.new(:parent)
      end
      verify "got its parent set" do
        equal(returned.parent, :parent)
      end

    end
  end
end
