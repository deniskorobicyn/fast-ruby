require 'benchmark/ips'
require 'active_support/core_ext/object/try'

class A
  def test
  end
end

class B
  def no
  end
end

def fast
  a = A.new
  a && a.test
  a = nil
  a && a.test
end

def slow
  a = A.new
  a.try(:test)
  a = nil
  a.try(:test)
end

Benchmark.ips do |x|
  x.report("try")       { slow }
  x.report("simple if") { fast }
  x.compare!
end
