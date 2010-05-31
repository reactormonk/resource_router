require 'uri'
module ResourceRouter
  class Walker

    def initialize(url, start_node)
      @uri = URI::parse(url)
      @remaining_paths = @uri.path.split("/")
      @remaining_domains = @uri.host.split('.')
      @variables = {}
    end

    # @return [Array<String>] Paths still to be assigned to a node.
    attr_reader :remaining_paths

    # @return [Array<String>] Domains that may be assigned to a node.
    attr_reader :remaining_domains

    # @return [Hash{Node => Object}] walked Nodes may store information here
    #   (for variable collecting).
    attr_reader :variables

  end
end
