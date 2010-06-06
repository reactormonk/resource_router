require 'resource_router/tree/abstract_node'
module ResourceRouter
  module Tree
    class VariableNode < AbstractNode

      # @param [String] key Key of the matched path.
      def initialize(key)
        @key = key
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
