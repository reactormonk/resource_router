require 'resource_router/tree/node_set/abstract_node_set'
suite "ResourceRouter" do
  suite "Tree" do
    suite "NodeSet" do
      suite "AbstractNodeSet" do

        exercise "a new AbstractNodeSet" do
          ResourceRouter::Tree::NodeSet::AbstractNodeSet.new
        end
        verify "got children" do
          returned.respond_to?(:children)
        end
        then_verify "... which is an Array" do
          kind_of(Array, returned.children)
        end
        verify "got an optimize callback" do
          returned.respond_to?(:optimize)
        end
        verify "got a #find_children" do
          returned.respond_to?(:find_children)
        end

      end
    end
  end
end
