require 'benchmark/ips'

def slow
  #a = 1
  a = 1 unless defined?(a)
  a
end

def fast
  #a = 1
  a ||=3
  a
end

Benchmark.ips do |x|
  x.report('defined?') { slow }
  x.report('||=')      { fast }
  x.compare!
end

