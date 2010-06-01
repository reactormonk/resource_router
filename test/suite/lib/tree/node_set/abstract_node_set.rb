require 'resource_router/tree/node_set/abstract_node_set'
suite "ResourceRouter" do
  suite "Tree" do
    suite "NodeSet" do
      suite "AbstractNodeSet", :use => :node_set do

        setup do
          @node_set_class = ResourceRouter::Tree::NodeSet::AbstractNodeSet
        end

      end
    end
  end
end
