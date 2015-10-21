require 'benchmark/ips'
require 'active_support/core_ext/module/delegation'

class A
  def test
  end
end

def fast
  eval "
    class TestStraight
      attr_reader :a

      def initialize(a)
        @a = a
      end

      def test
        a.test
      end
    end

    a = A.new
    TestStraight.new(a).test
  "
end

def slow
  eval "
    class TestDelegate
      attr_reader :a

      def initialize(a)
        @a = a
      end

      delegate :test, to: :a
    end

    a = A.new
    TestDelegate.new(a).test
  "
end

Benchmark.ips do |x|
  x.report('straight_call') { fast }
  x.report('delegate')      { slow }
  x.compare!
end
