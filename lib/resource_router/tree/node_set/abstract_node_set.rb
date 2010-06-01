module ResourceRouter
  module Tree
    module NodeSet

      class AbstractNodeSet

        def initialize
          @children = []
        end

        # @return [Array<Node>] contains child Nodes
        attr_reader :children

        # Callback if all Nodes are added, so you can do static optimizations
        # @abstract
        def optimize
        end

        # @param [Walker] walker find the matching child Nodes for that walker
        # @return [Array<Node>] possible Nodes
        # @abstract
        def find_children(walker)
          @children.select {|child| child.matches?(walker) }
        end

      end

    end
  end
end
