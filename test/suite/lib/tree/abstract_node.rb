require 'resource_router/tree/abstract_node'
suite "ResourceRouter" do
  suite "Tree" do
    suite "AbstractNode", :use => :node do
      setup do
        @node_class = ResourceRouter::Tree::AbstractNode
      end

      suite "#add_child" do
        setup do
          @node = @node_class.new
          @child = @node_class.new
        end

        exercise "add it" do
          @node.add_child(@child)
        end
        verify "child got added" do
          equal([@child], @node.children)
        end
        verify "parent got set" do
          equal(@node, @child.parent)
        end
      end

      suite "#<=>" do
        setup do
          @classes = [
            Class.new(@node_class),
            Class.new(@node_class),
            Class.new(@node_class),
            Class.new(@node_class)
          ]
          @classes.each.with_index {|klass, i| klass.priority = i}
          @nodes = @classes.map {|klass| klass.new}
          @nodes.shuffle!
        end

        exercise "#sort" do
          @nodes.sort
        end
        verify "it got the correct order" do
          equal(returned.map{|e| e.class}, @classes.reverse) # [3,2,1,0]
        end

      end

    end
  end
end
