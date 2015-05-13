require 'benchmark/ips'

ARRAY = [*1..10]

def slow
  [1] + ARRAY
end

def fast
  ARRAY + [1]
end

Benchmark.ips do |x|
  x.report('Array#begin') { slow }
  x.report('Array#end')        { fast }
  x.compare!
end

