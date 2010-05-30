module ResourceRouter
  module Tree
    class AbstractNode

      def initialize(parent)
        @parent = parent
        @node_set = NodeSet.new
      end

      # @return [Array<Node>] child nodes
      attr_reader :children

      # @return [Node] parent node
      attr_reader :parent

      # @return [Symbol] key for storing variables in the Walker
      attr_reader :name

      # Most basic method that checks wherever the given node may be matched
      # to the remaining path.
      # @param [Walker] walker matches for that walker?
      # @return [Boolean]
      # @abstract
      def matches?(walker)
        raise NotImplemented
      end

      # @param [Walker] walker set the variables in that walker
      # @return [Object] saved to Walker#variables with key #name
      # @abstract
      def visit(walker)
        raise NotImplemented
      end

      def to_proc
        method(:visit)
      end

    end
  end
end
