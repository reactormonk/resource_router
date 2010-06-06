require 'resource_router/tree/abstract_node'
module ResourceRouter
  module Tree
    class GlobNode < AbstractNode

      # @param [String] key  key of the matched path part.
      def initialize(key)
        @key = key
        node_set.add_child(self)
      end

      self.priority = 0

      # @see AbstractNode#visit
      def visit(runner)
        Array(runner.variables[self]) + [runner.remaining_paths.shift]
      end

      # @see AbstractNode#matches?
      def matches?(runner)
        true
      end

    end
  end
end
