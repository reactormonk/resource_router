module ResourceRouter
  module Tree
    class RootNode < AbstractNode

      def visit(runner)
        unless runner.remaining_paths.shift == ""
          raise "you did something wrong."
        end
      end

      undef :matches?

    end
  end
end
