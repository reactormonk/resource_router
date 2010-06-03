module ResourceRouter
  class Runner

    # @param [Node] node the node this runner should visit next
    # @param [Array<String>] paths still to walk
    # @param [Array<String>] domains still to walk
    # @param [Hash{Symbol => Object}] variables already set
    def initialize(node, paths, domains, variables = {})
      @node = node
      @remaining_paths = paths
      @remaining_domains = domains
      @variables = variables
    end

    # @return [Array<String>] Paths still to be assigned to a node.
    attr_reader :remaining_paths

    # @return [Array<String>] Domains that may be assigned to a node.
    attr_reader :remaining_domains

    # @return [Hash{Symbol => Object}] Nodes should store matched stuff in
    #   this Hash.
    attr_reader :variables

    # @return [Node] the node where this runner is at.
    attr_reader :node

    # Visit the current node and move on to the next one.
    # @return [Array<Node>] leftover nodes
    def run
      variables.merge!({@node.name => @node.visit(self)})
      children = @node.find_children(self)
      @node = children.shift
      children
    end

    # Guess.
    def dup
      self.class.new(@node, @remaining_paths.dup, @remaining_domains.dup, @variables.dup)
    end
  end
end
