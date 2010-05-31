module ResourceRouter
  module Tree
    class AbstractNode

      def initialize(parent)
        @parent = parent
        @node_set = self.class.node_set.new
      end

      class << self
        # @return [NodeSet] the nodeset to use
        attr_accessor :node_set
      end

      # @return [Array<Node>] child nodes
      def children
        @node_set.children
      end

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

      # A Walker visits the Node when entering it.
      # @param [Walker] walker set the variables in that walker
      # @return [Object] saved to {Walker#variables} with key {#name}
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
