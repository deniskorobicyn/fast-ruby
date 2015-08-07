require 'benchmark/ips'

FIRST_ARRAY = [*1..100]
OTHER_ARRAY = [*50..100]

def fast
  (OTHER_ARRAY - FIRST_ARRAY).empty?
end

def slow
  (OTHER_ARRAY & FIRST_ARRAY)
end

Benchmark.ips do |x|
  x.report('Array#-') { fast }
  x.report('Array#&') { slow }
  x.compare!
end

