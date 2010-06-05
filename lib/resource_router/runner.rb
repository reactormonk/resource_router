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

    # @return [Hash{Node => Object}] Nodes should store matched stuff in
    #   this Hash.
    attr_reader :variables

    # @return [Node] the node where this runner is at.
    attr_accessor :node

    # @return [Proc] the action to call
    def action
      @node.action
    end

    # Visit the current node.
    # @return [void]
    def visit
      if variable = @node.visit(self)
        variables.merge!({@node => variable})
      end
    end

    # @return [Array<Node>] possible child nodes
    def find_children
      @node.find_children(self)
    end

    # Guess.
    def dup
      self.class.new(@node, @remaining_paths.dup, @remaining_domains.dup, @variables.dup)
    end
  end
end
