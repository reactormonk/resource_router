module ResourceRouter
  module Tree
    class RootNode < AbstractNode

      def visit(runner)
        unless runner.remaining_paths.shift == ""
          raise 'RootNode should not be visited unless the path is ""'
        end
      end

      undef :matches?

    end
  end
end
