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
end
