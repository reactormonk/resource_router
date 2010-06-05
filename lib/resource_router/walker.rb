require 'uri'
require 'resource_router/runner'
module ResourceRouter
  class Walker

    # @param [String] url the URL to parse
    # @param [Node] root_node the staring node (likely a RootNode)
    def initialize(url, root_node)
      @uri = URI::parse(url)
      @paths = @uri.path.split("/")
      @domains = @uri.host.split('.')
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
        runners += generate_child_runners(runner)
        return runner if runner.remaining_paths.empty?
      end
    end

    private

    def generate_child_runners(runner)
      children = runner.find_children
      children.map do |node|
        runner.dup.tap {|run| run.node = node }
      end
    end

  end
end
