require 'benchmark/ips'
require 'active_support/core_ext/module/delegation'


def fast
  eval <<BLOCK
    class Test
      def initialize(a)
        @a = a
      end

      def test
        a.test
      end
    end
  BLOCK
end

def slow
  eval <<BLOCK
  class Test
    attr_reader :a

    def initialize(a)
      @a = a
    end

    delegate :test, to: a
  end
  BLOCK
end

Benchmark.ips do |x|
  x.report('straight_call') { slow }
  x.report('delegate')      { fast }
  x.compare!
end
