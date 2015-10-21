require 'benchmark/ips'


def fast
  a = 0

  a
end

def some_method
  0
end

def slow
  some_method
end

Benchmark.ips do |x|
  x.report("method")   { slow }
  x.report("variable") { fast }
  x.compare!
end

