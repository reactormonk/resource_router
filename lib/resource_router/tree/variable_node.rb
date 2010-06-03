require 'resource_router/tree/abstract_node'
module ResourceRouter
  module Tree
    class VariableNode < AbstractNode

      # @param [String] name Name for this node and therefore key of the
      #   matched path.
      def initialize(name)
        @name = name
      end

      self.priority = 5

      # @see AbstractNode#visit
      def visit(runner)
        runner.remaining_paths.shift
      end

      # @see AbstractNode#matches?
      def matches?(runner)
        true
      end

    end
  end
end
