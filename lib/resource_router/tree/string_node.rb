require 'resource_router/tree/abstract_node'
module ResourceRouter
  module Tree
    class StringNode < AbstractNode

      # @param [String] string The String to be matched by this Node.
      def initialize(string)
        @string = @name = string
      end

      self.priority = 7

      # @return [String] The string this Node should match.
      attr_reader :string

      # @see AbstractNode#visit
      def visit(runner)
        runner.remaining_paths.shift
        nil
      end

      # @see AbstractNode#matches?
      def matches?(runner)
        runner.remaining_paths.first == string
      end

    end
  end
end
