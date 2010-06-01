require 'resource_router/tree/abstract_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "AbstractNode", :use => :node do
      setup do
        @node_class = ResourceRouter::Tree::AbstractNode
      end
    end
  end
end
