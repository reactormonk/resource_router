require 'uri'
require 'resource_router/runner'
module ResourceRouter
  class Walker

    # @param [String] url the URL to parse
    # @param [Node] node the staring node
    def initialize(url, node)
      @uri = URI::parse(url)
      @paths = @uri.path.split("/")
      @domains = @uri.host.split('.')
    end

    # @return [Array<String>]
    attr_reader :paths

    # @return [Array<String>]
    attr_reader :domains

    # @return [Runner,nil] the successful Runner finding a matching Node.
    def recognize
      runners = [Runner.new(node, @paths, @domains)]
      successful_runner = nil
      while !successful_runner || !runners.empty?
        runner = runners.first
        nodes = runner.run
        nodes.each {|node| runners.push(runner.dup)}
          # I'm creating runners for further branching here.
        runners.shift unless runner.node
          # Kick it if it's got no new Node, aka dead end.
        successful_runner = runner if runner.remaining_paths.empty?
      end
      successful_runner
    end

  end
end
