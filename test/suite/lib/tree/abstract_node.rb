require 'resource_router/tree/abstract_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "AbstractNode" do

      exercise "a new AbstractNode" do
        ResourceRouter::Tree::AbstractNode.new(:parent)
      end
      verify "got its parent set" do
        equal(returned.parent, :parent)
      end

    end
  end
end
