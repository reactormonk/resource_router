require 'resource_router/runner'
module ResourceRouter
  class Walker

    # @param [String] url the URL to parse
    # @param [Node] root_node the staring node (likely a RootNode)
    def initialize(env, root_node)
      @paths = env['REQUEST_PATH'].split("/")
      @domains = env['HTTP_HOST'].split('.')
      @root_node = root_node
    end

    # @return [Array<String>]
    attr_reader :paths

    # @return [Array<String>]
    attr_reader :domains

    # @return [Runner,nil] the successful Runner finding a matching Node.
    def recognize
      runners = [Runner.new(@root_node, @paths, @domains)]
      while !runners.empty?
        runner = runners.shift
        runner.visit
        runners += runner.generate_child_runners
        return runner if runner.remaining_paths.empty?
      end
    end

  end
end
