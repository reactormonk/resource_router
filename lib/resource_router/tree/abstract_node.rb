require 'resource_router/tree/node_set/abstract_node_set'
module ResourceRouter
  module Tree
    class AbstractNode

      # @param [Node] parent the parent node
      def initialize(parent)
        @parent = parent
        @node_set = (self.class.node_set ||= NodeSet::AbstractNodeSet).new
      end

      class << self
        # @return [NodeSet] the nodeset to use
        attr_accessor :node_set
      end

      # @return [Array<Node>] child Nodes
      def children
        @node_set.children
      end

      # @return [NodeSet] the NodeSet holding the children
      attr_reader :node_set

      # @return [Node] parent node
      attr_reader :parent

      # @return [Symbol] key for storing variables in the Runner
      attr_reader :name

      # Most basic method that checks wherever the given node may be matched
      # to the remaining path.
      # @param [Runner] runner matches for that runner?
      # @return [Boolean]
      # @abstract
      def matches?(runner)
        raise NotImplemented
      end

      # A Runner visits the Node when entering it.
      # @param [Runner] runner set the variables in that runner
      # @return [Object] saved to {Runner#variables} with key {#name}
      # @abstract
      def visit(runner)
        raise NotImplemented
      end

    end
  end
end
