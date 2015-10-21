require 'benchmark/ips'

def fast
  a = 0

  a
end

def slow
  def a
    0
  end

  a
end

Benchmark.ips do |x|
  x.report("method")   { slow }
  x.report("variable") { fast }
  x.compare!
end

