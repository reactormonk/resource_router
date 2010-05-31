require 'resource_router/walker'
require 'ruby-debug'

suite "ResourceRouter" do
  suite "Walker" do

    setup do
      @url = "http://foo.bar.baz/make/me/a/sandwitch/"
    end

    exercise "a new Walker" do
      ResourceRouter::Walker.new(@url, nil)
    end
    verify "got an array of paths" do
      equal(returned.remaining_paths, [''] + %w(make me a sandwitch))
    end
    verify "got an array of domains" do
      equal(returned.remaining_domains, %w(foo bar baz))
    end
    verify "got a #variables with a hash" do
      kind_of(Hash, returned.variables)
    end

  end
end
