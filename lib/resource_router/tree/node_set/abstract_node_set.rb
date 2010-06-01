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

        # @param [Runner] runner find the matching child Nodes for that runner
        # @return [Array<Node>] possible Nodes
        # @abstract
        def find_children(runner)
          @children.select {|child| child.matches?(runner)}
        end

      end

    end
  end
end
